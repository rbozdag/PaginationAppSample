//
//  ModelsRequest.swift
//  PaginationAssignment
//
//  Created by Rahmi Bozdağ on 16.02.2019.
//  Copyright © 2019 Rahmi Bozdag. All rights reserved.
//

import Foundation
import Networking

protocol ModelRequestType {
    init(manufacturerId: String, page: Int, pageSize: Int)
    @discardableResult
    func execute(succeed: @escaping (PagedItemsResponse) -> Void, failed: @escaping (ErrorResponse) -> Void) -> URLSessionTask?
}

struct ModelRequest: ModelRequestType, Endpoint {
    typealias SuccessType = PagedItemsResponse

    var parameters: RequestParameters? = NetworkConfiguration.defaultParameters

    var path: String = "/car-types/main-types"

    var method: HTTPMethodEnum = .get

    init(manufacturerId: String, page: Int, pageSize: Int) {
        parameters!["manufacturer"] = manufacturerId
        parameters!["page"] = page
        parameters!["pageSize"] = pageSize
    }
}
