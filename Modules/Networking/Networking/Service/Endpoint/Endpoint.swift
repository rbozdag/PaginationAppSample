//
//  Endpoint.swift
//  Networking
//
//  Created by Rahmi Bozdağ on 16.02.2019.
//  Copyright © 2019 Rahmi Bozdag. All rights reserved.
//

import Foundation

public protocol Endpoint {
    associatedtype SuccessType
    associatedtype ErrorType: NetworkError
    
    var baseUrl: URL { get }
    var path: String { get }
    var method: HTTPMethodEnum { get }
    var responseContentType: MimeTypeEnum { get }
    var parameters: RequestParameters? { get }
    var headers: RequestHTTPHeaders? { get }
    var parameterEncoding: ParameterEncoding { get }
    
    var requestChecksumGenerator: ((RequestParameters) -> String)? { get }
    var responseChecksumValidator: ((Data) -> Bool)? { get }
    
    func execute(succeed: @escaping (SuccessType) -> Void, failed: @escaping (ErrorType) -> Void) -> URLSessionTask?
}

public class AnyEndpoint<E: Endpoint>: Endpoint {
    private let endpoint: E
    public var baseUrl: URL { get { return endpoint.baseUrl } }
    public var path: String { get { return endpoint.path } }
    public var method: HTTPMethodEnum { get { return endpoint.method } }
    public var parameters: RequestParameters? { get { return endpoint.parameters } }
    public var headers: RequestHTTPHeaders? { get { return endpoint.headers } }
    public var parameterEncoding: ParameterEncoding { get { return endpoint.parameterEncoding } }
    public var responseContentType: MimeTypeEnum { get { return endpoint.responseContentType } }
    
    public var requestChecksumGenerator: ((RequestParameters) -> String)? { get { return endpoint.requestChecksumGenerator } }
    public var responseChecksumValidator: ((Data) -> Bool)? { get { return endpoint.responseChecksumValidator } }
    
    public func execute(succeed: @escaping (E.SuccessType) -> Void, failed: @escaping (E.ErrorType) -> Void) -> URLSessionTask? {
        return endpoint.execute(succeed: succeed, failed: failed)
    }
    
    public init(_ endpoint: E) {
        self.endpoint = endpoint
    }
}
