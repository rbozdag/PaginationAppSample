//
//  ErrorResponse.swift
//  PaginationAssignment
//
//  Created by Rahmi Bozdağ on 16.02.2019.
//  Copyright © 2019 Rahmi Bozdag. All rights reserved.
//

import Foundation
import Networking

struct ErrorResponse: Codable, NetworkError {

    init(with error: NetworkErrorEnum, httpStatus: HTTPStatusCode?) {
        self.error = error.localizedDescription
        status = httpStatus?.rawValue ?? HTTPStatusCode.badRequest.rawValue
        message = "NetworkError_\(error.rawValue)".localized()
        path = ""
        timestamp = ""
    }

    let timestamp: String
    let status: Int
    let error: String
    let message: String
    let path: String
}
