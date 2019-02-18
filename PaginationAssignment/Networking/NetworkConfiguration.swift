//
//  NetworkConfiguration.swift
//  PaginationAssignment
//
//  Created by Rahmi Bozdağ on 16.02.2019.
//  Copyright © 2019 Rahmi Bozdag. All rights reserved.
//

import Foundation
import Networking

struct NetworkConfiguration {
    static let endpointRouter: EndpointRouter = {
        return EndpointRouter(dispatcher: UrlSessionNetworkDispatch(session: URLSession(configuration: URLSessionConfiguration.default)))
    }()
    
    static let baseUrl = URL(string: "http://foo.bar/v1")!
    static let defaultParameters: RequestParameters? = [:]
}
