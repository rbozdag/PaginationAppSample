//
//  ViewController.swift
//  PaginationAssignment
//
//  Created by Rahmi Bozdağ on 16.02.2019.
//  Copyright © 2019 Rahmi Bozdag. All rights reserved.
//

import UIKit
import Networking
import PaginationAdapter

final class ManufacturersVC: BaseVC {
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            ManufacturersCellView.register(to: tableView)
            PaginationErrorCellView.register(to: tableView)
            PaginationLoadingCellView.register(to: tableView)

            tableView.rowHeight = UITableView.automaticDimension
            tableView.tableFooterView = UIView(frame: CGRect.zero)
        }
    }

    lazy var paginationAdapter = SectionBasedPagedAdapter(tableView: tableView, pagedTableDelegate: self, pagedDataSource: viewModel)

    var viewModel: ManufacturersVMType!
    var router: ManufacturersRouterType!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "manufacturers.page.title".localized()
        startAnimating(type: .ballScaleRippleMultiple)

        bindViewModel()
        viewModel.loadMoreData()
    }

    private func bindViewModel() {
        viewModel.onItemsUpdated = { [weak self] page in
            guard let this = self else { return }
            this.hidePageError()
            this.paginationAdapter.onPageLoaded(this.tableView, section: page)
        }

        viewModel.onLoadingStatusChanged = { [weak self] isLoading in
            guard let this = self else { return }
            this.paginationAdapter.refreshPaginationStatus(this.tableView)

            if isLoading, this.viewModel.currentPage == 0 {
                this.startAnimating(type: .ballScaleRippleMultiple)
            } else {
                this.stopAnimating()
            }
        }

        viewModel.onLoadingError = { [weak self] errorMessage in
            guard let this = self else { return }
            this.paginationAdapter.refreshPaginationStatus(this.tableView)

            if this.viewModel.currentPage == 0 {
                this.showPageError(with: errorMessage, reloadAction: { [weak self] in self?.viewModel.reloadData() })
            } else {
                this.hidePageError()
            }
        }
    }
}

extension ManufacturersVC: PagedTableDelegate {
    func getErrorCellView(_ tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PaginationErrorCellView.reuseIdentifier) as! PaginationErrorCellView
        cell.setError(message: viewModel.loadingErrorMessage)
        cell.reloadAction = { [weak self] in
            self?.viewModel.reloadData()
        }
        return cell
    }

    func getLoadingCellView(_ tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PaginationLoadingCellView.reuseIdentifier) as! PaginationLoadingCellView
        return cell
    }

    func getCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ManufacturersCellView.reuseIdentifier, for: indexPath) as! ManufacturersCellView

        if let typeData = viewModel.getItem(page: indexPath.section, index: indexPath.row) {
            cell.setName(typeData.name)
        } else {
            cell.clear()
        }

        cell.backgroundColor = tableView.getOrder(of: indexPath) % 2 == 0 ? UIColor(white: 0.9, alpha: 1) : UIColor.white
        return cell
    }

    func getNumberOfRows(in section: Int) -> Int {
        return viewModel.getItemCount(at: section)
    }

    public func didSelectRowAt(_ tableView: UITableView, indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        guard let selectedManufacturer = viewModel.getItem(page: indexPath.section, index: indexPath.row) else {
            return
        }

        router.onManufacturerSelected(with: selectedManufacturer)
    }
}

