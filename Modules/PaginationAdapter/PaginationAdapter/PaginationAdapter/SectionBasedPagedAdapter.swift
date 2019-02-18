//
//  SectionBasedPagedAdapter.swift
//  AutoCodingAssignment
//
//  Created by Rahmi Bozdağ on 16.02.2019.
//  Copyright © 2019 Rahmi Bozdag. All rights reserved.
//

import Foundation
import UIKit

public class SectionBasedPagedAdapter: NSObject, UITableViewDelegate, UITableViewDataSource {

    private weak var pagedDataSource: PagedDataSource?
    private weak var pagedTableDelegate: PagedTableDelegate?

    public init(tableView: UITableView, pagedTableDelegate: PagedTableDelegate, pagedDataSource: PagedDataSource) {
        self.pagedTableDelegate = pagedTableDelegate
        self.pagedDataSource = pagedDataSource

        super.init()

        tableView.delegate = self
        tableView.dataSource = self
    }

    public func numberOfSections(in tableView: UITableView) -> Int {
        guard let pagedDataSource = pagedDataSource else { return 0 }

        return pagedDataSource.totalPageCount + 1
    }

    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let pagedDataSource = pagedDataSource else { return }

        if pagedDataSource.hasNextPage {
            let cellOrder = tableView.getOrder(of: indexPath)
            let totalRow = tableView.totalRowCount
            let visiblePercent = (cellOrder + 1) * 100 / totalRow
            if visiblePercent >= pagedDataSource.prefetchPercentage {
                pagedDataSource.loadMoreData()
            }
        }
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let pagedDataSource = pagedDataSource, let delegate = pagedTableDelegate else { return UITableViewCell(frame: .zero) }

        if isStatusSection(indexPath.section) {
            if pagedDataSource.hasLoadingError {
                return delegate.getErrorCellView(tableView)
            } else {
                return delegate.getLoadingCellView(tableView)
            }
        }

        return delegate.getCell(tableView, cellForRowAt: indexPath)
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let pagedDataSource = pagedDataSource else { return 0 }

        if isStatusSection(section) {
            return pagedDataSource.hasNextPage ? 1 : 0
        }

        return pagedDataSource.getItemCount(at: section)
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let delegate = pagedTableDelegate else { return }

        if isStatusSection(indexPath.section) {
            tableView.deselectRow(at: indexPath, animated: false)
            return
        }

        delegate.didSelectRowAt(tableView, indexPath: indexPath)
    }

    public func isStatusSection(_ section: Int) -> Bool {
        guard let pagedDataSource = pagedDataSource else { return false }
        return section == pagedDataSource.totalPageCount
    }
}

extension SectionBasedPagedAdapter: PaginationAdapter {

    public func onPageLoaded(_ tableView: UITableView, section: Int) {
        guard let pagedDataSource = pagedDataSource else { return }

        if section == 0 {
            tableView.reloadData()
        } else {
            tableView.beginUpdates()
            tableView.reloadSections([section], with: .automatic)
            tableView.reloadSections([pagedDataSource.totalPageCount], with: .fade)

            tableView.endUpdates()
        }
    }

    public func refreshPaginationStatus(_ tableView: UITableView) {
        guard let pagedDataSource = pagedDataSource else { return }

        tableView.beginUpdates()
        tableView.reloadSections([pagedDataSource.totalPageCount], with: .fade)
        tableView.endUpdates()
    }
}


