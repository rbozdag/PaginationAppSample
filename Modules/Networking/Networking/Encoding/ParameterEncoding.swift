//
//  ParameterEncoding.swift
//  Networking
//
//  Created by Rahmi Bozdağ on 16.02.2019.
//  Copyright © 2019 Rahmi Bozdag. All rights reserved.
//

import Foundation

public typealias RequestParameters = [String: Any]

public protocol ParameterEncoder {
    func encode(urlRequest: inout URLRequest, with parameters: RequestParameters) throws
}

public enum ParameterEncoding {
    case urlEncoding
    case jsonEncoding
}

public extension ParameterEncoding {
    public func encode(urlRequest: inout URLRequest,
                       parameters: RequestParameters?) throws {

        guard let parameters = parameters else { return }

        do {
            switch self {
            case .urlEncoding:
                try URLParameterEncoder().encode(urlRequest: &urlRequest, with: parameters)
            case .jsonEncoding:
                try JSONParameterEncoder().encode(urlRequest: &urlRequest, with: parameters)
            }
        } catch {
            throw error
        }
    }
}
