//
//  PagedItemsResponse.swift
//  PaginationAssignment
//
//  Created by Rahmi Bozdağ on 16.02.2019.
//  Copyright © 2019 Rahmi Bozdag. All rights reserved.
//

import Foundation

struct PagedItemsResponse: Codable {
    let page: Int
    let pageSize: Int
    let totalPageCount: Int
    let wkda: [String: String]
}
