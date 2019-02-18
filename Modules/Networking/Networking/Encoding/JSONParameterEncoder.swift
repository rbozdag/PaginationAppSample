//
//  JSONParameterEncoder.swift
//  Networking
//
//  Created by Rahmi Bozdağ on 16.02.2019.
//  Copyright © 2019 Rahmi Bozdag. All rights reserved.
//

import Foundation

public struct JSONParameterEncoder: ParameterEncoder {
    public func encode(urlRequest: inout URLRequest, with parameters: RequestParameters) throws {
        do {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            if urlRequest.value(forHTTPHeaderField: HTTPHeaderKeyEnum.contentType.rawValue) == nil {
                urlRequest.setValue(MimeTypeEnum.applicationJson.rawValue, forHTTPHeaderField: HTTPHeaderKeyEnum.contentType.rawValue)
            }
        } catch {
            throw NetworkErrorEnum.encodingFailed
        }
    }
}
