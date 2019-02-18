//
//  Pagination.swift
//  AutoCodingAssignment
//
//  Created by Rahmi Bozdağ on 16.02.2019.
//  Copyright © 2019 Rahmi Bozdag. All rights reserved.
//

import Foundation
import UIKit

public protocol PagedTableDelegate: class {
    func getErrorCellView(_ tableView: UITableView) -> UITableViewCell
    func getLoadingCellView(_ tableView: UITableView) -> UITableViewCell
   
    func getCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    func getNumberOfRows(in section: Int) -> Int
    
    func didSelectRowAt(_ tableView: UITableView, indexPath: IndexPath)
}

public protocol PagedDataSource: class {
    var totalPageCount: Int { get }
    var pageSize: Int { get }
    var currentPage: Int { get }
    var hasNextPage: Bool { get }
    var hasLoadingError: Bool { get }
    var prefetchPercentage: Int { get }

    func getItemCount(at page: Int) -> Int
    func loadMoreData()
}

public protocol PaginationAdapter {
    func onPageLoaded(_ tableView: UITableView, section: Int)
    func refreshPaginationStatus(_ tableView: UITableView)
}
