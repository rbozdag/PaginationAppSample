//
//  HTTPHeader.swift
//  Networking
//
//  Created by Rahmi Bozdağ on 16.02.2019.
//  Copyright © 2019 Rahmi Bozdag. All rights reserved.
//

import Foundation

public typealias RequestHTTPHeaders = [String: String]

public enum HTTPHeaderKeyEnum: String {
    case contentType = "Content-Type"
    case transferEncoding = "Transfer-Encoding"
    case setCookie = "Set-Cookie"
    case date = "Date"
    case acceptLanguage = "Accept-Language"
    case geolocation = "Geolocation"
    case checkSum = "X-CheckSum"
    case token = "X-Token"
    case clientId = "X-Client-Id"
}


