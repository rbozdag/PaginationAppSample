//
//  ManufacturerEndpoint.swift
//  PaginationAssignment
//
//  Created by Rahmi Bozdağ on 16.02.2019.
//  Copyright © 2019 Rahmi Bozdag. All rights reserved.
//

import Foundation
import Networking

protocol ManufacturerRequestType {
    init(page: Int, pageSize: Int)
    @discardableResult
    func execute(succeed: @escaping (PagedItemsResponse) -> Void, failed: @escaping (ErrorResponse) -> Void) -> URLSessionTask?
}

struct ManufacturerRequest: ManufacturerRequestType, Endpoint {

    typealias SuccessType = PagedItemsResponse

    var parameters: RequestParameters? = NetworkConfiguration.defaultParameters

    var path: String = "/car-types/manufacturer"

    var method: HTTPMethodEnum = .get

    init(page: Int, pageSize: Int) {
        parameters!["page"] = page
        parameters!["pageSize"] = pageSize
    }
}
