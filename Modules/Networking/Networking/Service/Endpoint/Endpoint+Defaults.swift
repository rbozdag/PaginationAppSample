//
//  Endpoint+Defaults.swift
//  Networking
//
//  Created by Rahmi Bozdağ on 16.02.2019.
//  Copyright © 2019 Rahmi Bozdag. All rights reserved.
//

import Foundation

public extension Endpoint {
    var parameterEncoding: ParameterEncoding {
        get {
            return method == .get ? ParameterEncoding.urlEncoding : ParameterEncoding.jsonEncoding
        }
    }

    var responseContentType: MimeTypeEnum {
        get {
            return MimeTypeEnum.applicationJson
        }
    }
    
    var requestChecksumGenerator: ((RequestParameters) -> String)? {
        return nil
    }
    
    var responseChecksumValidator: ((Data) -> Bool)? {
        return nil
    }
    
    var headers: RequestHTTPHeaders? {
        return nil
    }
}
