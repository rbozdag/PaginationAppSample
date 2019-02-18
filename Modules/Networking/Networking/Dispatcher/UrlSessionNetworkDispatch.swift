//
//  UrlSessionNetworkDispatch.swift
//  Networking
//
//  Created by Rahmi Bozdağ on 16.02.2019.
//  Copyright © 2019 Rahmi Bozdag. All rights reserved.
//

import Foundation

public final class UrlSessionNetworkDispatch: NetworkDispatcher {
    private let session: URLSession

    public init(session: URLSession) {
        self.session = session
    }

    public func execute(urlRequest: URLRequest, completion: @escaping NetworkDispatchCompletion) -> URLSessionTask? {
        let task = session.dataTask(with: urlRequest, completionHandler: completion)
        return task
    }
}
