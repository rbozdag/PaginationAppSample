//
//  EndpointRouter.swift
//  Networking
//
//  Created by Rahmi Bozdağ on 16.02.2019.
//  Copyright © 2019 Rahmi Bozdag. All rights reserved.
//

import Foundation

public class EndpointRouter {
    let dispatcher: NetworkDispatcher
    
    public init(dispatcher: NetworkDispatcher) {
        self.dispatcher = dispatcher
    }
    
    public func execute<E>(endpoint: AnyEndpoint<E>, defaultHeader: (() -> RequestHTTPHeaders?)? = nil, statusHandler: @escaping (RequestStatusEnum) -> ()) -> URLSessionTask? {
        do {
            var urlRequest = try buildRequest(from: endpoint)
            prepareHeader(from: endpoint, defaultHeader: defaultHeader, request: &urlRequest)
            
            statusHandler(.requestPrepared(urlRequest))
            
            let task = dispatcher.execute(urlRequest: urlRequest) { data, response, error in
                let httpStatusEnum = (response as? HTTPURLResponse)?.statusEnum
                
                if let error = error {
                    statusHandler(RequestStatusEnum.error(NetworkErrorEnum(error), httpStatusEnum))
                    return
                }
                
                guard let httpUrlResponse = response as? HTTPURLResponse else {
                    statusHandler(RequestStatusEnum.error(NetworkErrorEnum.nilResponse, httpStatusEnum))
                    return
                }
                
                guard httpUrlResponse.isValidContentType(expected: endpoint.responseContentType) else {
                    statusHandler(RequestStatusEnum.error(NetworkErrorEnum.invalidContentType, httpStatusEnum))
                    return
                }
                
                guard let data = data else {
                    statusHandler(RequestStatusEnum.error(NetworkErrorEnum.nilData, httpStatusEnum))
                    return
                }
                
                if let isValid = endpoint.responseChecksumValidator?(data), !isValid {
                    statusHandler(RequestStatusEnum.error(NetworkErrorEnum.invalidChecksum, httpStatusEnum))
                    return
                }
                
                statusHandler(RequestStatusEnum.response(data, httpUrlResponse))
            }
            
            if let task = task {
                statusHandler(.started(task))
                task.resume()
                return task
            } else {
                statusHandler(.error(NetworkErrorEnum.taskNotCreated, nil))
            }
        } catch {
            statusHandler(.error(NetworkErrorEnum(error), nil))
        }
        
        return nil
    }
    
    fileprivate func buildRequest<E>(from endpoint: AnyEndpoint<E>) throws -> URLRequest {
        var request = URLRequest(url: endpoint.baseUrl.appendingPathComponent(endpoint.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        
        request.httpMethod = endpoint.method.rawValue
        
        try configureParameters(parameters: endpoint.parameters,
                                bodyEncoding: endpoint.parameterEncoding,
                                request: &request)
        
        return request
    }
    
    fileprivate func prepareHeader<E>(from endpoint: AnyEndpoint<E>, defaultHeader: (() -> RequestHTTPHeaders?)?, request: inout URLRequest) {
        //endpoint header
        insertHeaders(headers: endpoint.headers, request: &request)
        
        //default header, it might contains session info
        if let defaultHeaders = defaultHeader?(), defaultHeaders.count > 0 {
            insertHeaders(headers: defaultHeaders, request: &request)
        }
        
        //x-checksum para
        prepareChecksum(from: endpoint, request: &request)
    }
    
    fileprivate func prepareChecksum<E>(from endpoint: AnyEndpoint<E>, request: inout URLRequest) {
        guard let checksumGenerator = endpoint.requestChecksumGenerator, let parameters = endpoint.parameters else { return }
        
        let checksum = checksumGenerator(parameters)
        insertHeaders(headers: [HTTPHeaderKeyEnum.checkSum.rawValue: checksum], request: &request)
    }
    
    fileprivate func configureParameters(parameters: RequestParameters?,
                                         bodyEncoding: ParameterEncoding,
                                         request: inout URLRequest) throws {
        try bodyEncoding.encode(urlRequest: &request, parameters: parameters)
    }
    
    fileprivate func insertHeaders(headers: RequestHTTPHeaders?, request: inout URLRequest) {
        guard let headers = headers else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
}
