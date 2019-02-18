//
//  CFNetworkErrors.swift
//  Networking
//
//  Created by Rahmi Bozdağ on 16.02.2019.
//  Copyright © 2019 Rahmi Bozdag. All rights reserved.
//

import Foundation

public extension CFNetworkErrors {
    public init?(_ error: Error) {
        let errorCode = (error as NSError).code
        if let cfNetworkError = CFNetworkErrors.init(rawValue: Int32(errorCode)) {
            self = cfNetworkError
        }
        return nil
    }
}
