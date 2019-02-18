//
//  RequestStatusEnum.swift
//  Networking
//
//  Created by Rahmi Bozdağ on 16.02.2019.
//  Copyright © 2019 Rahmi Bozdag. All rights reserved.
//

import Foundation

public enum RequestStatusEnum {
    case requestPrepared(_ request: URLRequest)
    case started(_ task: URLSessionTask)
    case response(_ data: Data, _ response: URLResponse)
    case error(_ error: NetworkErrorEnum, _ httpStatus: HTTPStatusCode?)
    case cancelled
}
