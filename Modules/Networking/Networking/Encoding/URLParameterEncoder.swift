//
//  URLParameterEncoder.swift
//  Networking
//
//  Created by Rahmi Bozdağ on 16.02.2019.
//  Copyright © 2019 Rahmi Bozdag. All rights reserved.
//

import Foundation

public struct URLParameterEncoder: ParameterEncoder {
    public func encode(urlRequest: inout URLRequest, with parameters: RequestParameters) throws {

        guard let url = urlRequest.url else { throw NetworkErrorEnum.missingURL }

        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
            urlComponents.queryItems = [URLQueryItem]()
            for (key, value) in parameters {
                let queryItem = URLQueryItem(name: key,
                                             value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
                urlComponents.queryItems?.append(queryItem)
            }
            urlRequest.url = urlComponents.url
        }

        if urlRequest.value(forHTTPHeaderField: HTTPHeaderKeyEnum.contentType.rawValue) == nil {
            urlRequest.setValue(MimeTypeEnum.formUrlEncoded.rawValue, forHTTPHeaderField: HTTPHeaderKeyEnum.contentType.rawValue)
        }
    }
}
