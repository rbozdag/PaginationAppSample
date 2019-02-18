//
//  NetworkError.swift
//  Networking
//
//  Created by Rahmi Bozdağ on 16.02.2019.
//  Copyright © 2019 Rahmi Bozdag. All rights reserved.
//

import Foundation

public protocol NetworkError {
    init(with error: NetworkErrorEnum, httpStatus: HTTPStatusCode?)
}
