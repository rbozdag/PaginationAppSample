//
//  Endpoint+Default.swift
//  PaginationAssignment
//
//  Created by Rahmi Bozdağ on 16.02.2019.
//  Copyright © 2019 Rahmi Bozdag. All rights reserved.
//

import Foundation
import Networking

extension Endpoint where SuccessType: Codable {
    typealias ErrorType = ErrorResponse

    var baseUrl: URL {
        return NetworkConfiguration.baseUrl
    }
}

extension Endpoint where SuccessType: Codable {

    @discardableResult
    func execute(succeed: @escaping (SuccessType) -> Void, failed: @escaping (ErrorResponse) -> Void) -> URLSessionTask? {
        return NetworkConfiguration.endpointRouter
            .execute(endpoint: AnyEndpoint(self)) { status in
                switch status {
                case .requestPrepared(_):
                    break
                case .started(_):
                    break
                case .error(let error, let httpStatus):
                    DispatchQueue.main.async {
                        self.completeWithError(error: error, httpStatus: httpStatus, failed)
                    }
                case .response(let data, let urlResponse):
                    DispatchQueue.main.async {
                        self.onResponseHandled(data, urlResponse, succeed, failed)
                    }
                case .cancelled:
                    break
                }
        }
    }

    func onResponseHandled(_ data: Data, _ response: URLResponse, _ succeed: @escaping (SuccessType) -> Void, _ failed: @escaping (ErrorResponse) -> Void) {
        let httpStatus = (response as? HTTPURLResponse)?.statusEnum
        let responseType = (response as? HTTPURLResponse)?.statusEnum?.responseType

        guard responseType == .success else {
            completeWithError(data: data, httpStatus: httpStatus, failed)
            return
        }

        do {
            try succeed(ResponseObjectMapper.convertToObject(type: SuccessType.self, data: data))
        } catch {
            completeWithError(error: NetworkErrorEnum.mappingError, httpStatus: httpStatus, failed)
        }
    }

    func completeWithError(data: Data, httpStatus: HTTPStatusCode?, _ failed: @escaping (ErrorResponse) -> Void) {
        do {
            let errorInstance = try ResponseObjectMapper.convertToObject(type: ErrorType.self, data: data)
            failed(errorInstance)
        } catch {
            completeWithError(error: NetworkErrorEnum(error), httpStatus: httpStatus, failed)
        }
    }

    func completeWithError(error: NetworkErrorEnum, httpStatus: HTTPStatusCode?, _ failed: @escaping (ErrorResponse) -> Void) {
        failed(ErrorType.init(with: error, httpStatus: httpStatus))
    }
}
