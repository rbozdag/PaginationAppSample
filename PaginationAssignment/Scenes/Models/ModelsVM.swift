//
//  MainTypesVM.swift
//  PaginationAssignment
//
//  Created by Rahmi Bozdağ on 16.02.2019.
//  Copyright © 2019 Rahmi Bozdag. All rights reserved.
//

import Foundation
import PaginationAdapter

protocol ModelsMVType: PagedDataSource {
    var onLoadingError: ((String) -> Void)? { get set }
    var onItemsUpdated: ((_ atPage: Int) -> Void)? { get set }
    var onLoadingStatusChanged: ((Bool) -> Void)? { get set }
    
    var manufacturer: Manufacturer { get }
    var loadingErrorMessage: String? { get }
    
    func reloadData()
    func getItem(page: Int, index: Int) -> AutoModel?
}

final class ModelsMV: ModelsMVType {
    let manufacturer: Manufacturer
    
    let pageSize: Int = 15
    let prefetchPercentage: Int = 70
    
    var onItemsUpdated: ((_ atPage: Int) -> Void)?
    private var pages: [[AutoModel]] = []
    
    var totalPageCount: Int = 0
    var currentPage: Int { return pages.count }
    
    var hasNextPage: Bool {
        return totalPageCount > currentPage
    }
    
    var onLoadingStatusChanged: ((Bool) -> Void)?
    var isLoading: Bool = false {
        didSet {
            if oldValue != isLoading {
                onLoadingStatusChanged?(isLoading)
            }
        }
    }
    
    var onLoadingError: ((String) -> Void)?
    var hasLoadingError: Bool { return loadingErrorMessage != nil }
    var loadingErrorMessage: String? {
        didSet {
            if let loadingErrorMessage = loadingErrorMessage {
                onLoadingError?(loadingErrorMessage)
            }
        }
    }
    
    let modelRequestType: ModelRequestType.Type
    
    init(manufacturer: Manufacturer, request: ModelRequestType.Type) {
        self.manufacturer = manufacturer
        self.modelRequestType = request
    }
    
    func reloadData() {
        clearLoadingError()
        loadMoreData()
    }
    
    
    func loadMoreData() {
        guard isNextPageLoadable() else { return }
        
        isLoading = true
        
        modelRequestType.init(manufacturerId: manufacturer.id, page: currentPage, pageSize: pageSize).execute(
            succeed: { [weak self] response in
                guard let this = self else { return }
                
                this.totalPageCount = response.totalPageCount
                this.pages.append(response.wkda.map(AutoModel.init).sorted { $0.id < $1.id })
                this.onItemsUpdated?(response.page)
                
                this.isLoading = false
            }, failed: { [weak self] error in
                guard let this = self else { return }
                
                this.loadingErrorMessage = error.message
                this.isLoading = false
        })
    }
    
    func getItemCount(at page: Int) -> Int {
        return pages[safe: page]?.count ?? 0
    }
    
    func getItem(page: Int, index: Int) -> AutoModel? {
        return pages[safe: page]?[safe: index]
    }
    
    private func clearLoadingError() {
        loadingErrorMessage = nil
    }
    
    private func isNextPageLoadable() -> Bool {
        return !isLoading && (hasNextPage || currentPage == 0) && !hasLoadingError
    }
}
