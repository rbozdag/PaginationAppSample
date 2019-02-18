//
//  NetworkDispatcher.swift
//  Networking
//
//  Created by Rahmi Bozdağ on 16.02.2019.
//  Copyright © 2019 Rahmi Bozdag. All rights reserved.
//

import Foundation

public typealias NetworkDispatchCompletion = (Data?, URLResponse?, Error?) -> Void

public protocol NetworkDispatcher: AnyObject {
    func execute(urlRequest: URLRequest, completion: @escaping NetworkDispatchCompletion) -> URLSessionTask?
}
