//
//  DecodableMapper.swift
//  Networking
//
//  Created by Rahmi Bozdağ on 16.02.2019.
//  Copyright © 2019 Rahmi Bozdag. All rights reserved.
//

import Foundation

public struct ResponseObjectMapper {
    public static func convertToObject<T: Decodable>(type: T.Type, data: Data?) throws -> T {
        if let data = data {
            let decoder = JSONDecoder()
            do {
                let instance = try decoder.decode(T.self, from: data)
                return instance
            } catch {
                throw NetworkErrorEnum.mappingError
            }
        }
        throw NetworkErrorEnum.mappingError
    }
}
