//
//  SceneManufacturersTests.swift
//  SceneModelsTests
//
//  Created by Rahmi Bozdağ on 16.02.2019.
//  Copyright © 2019 Rahmi Bozdag. All rights reserved.
//

import XCTest
import Quick
import Nimble
@testable import PaginationAssignment

class SceneModelsTests: QuickSpec {
    override func spec() {

        describe("As a user at Models Scene") {

            context("When scene appeared") {
                let vm = ModelsMV(manufacturer: Manufacturer(id: "test_id", name: "test_name"), request: MockModelRequest.self)
                vm.loadMoreData()
                waitUntil(timeout: 1) { done in done() }

                it("Then, First page data was loaded.", closure: {
                    expect(vm.isLoading).to(equal(false))
                })

                it("Then, First page data was loaded successfully.", closure: {
                    expect(vm.hasLoadingError).to(equal(false))
                })

                it("Then, I see only first page data.", closure: {
                    expect(vm.currentPage).to(equal(1))
                })

                it("Then, Listed 15 model for first page.", closure: {
                    expect(vm.getItemCount(at: 0)).to(equal(15))
                })

                it("Then, There is a next page to will be loaded.", closure: {
                    expect(vm.hasNextPage).to(equal(true))
                })

                it("Then, There are 2 page to will be loaded.", closure: {
                    expect(vm.totalPageCount - vm.currentPage).to(equal(2))
                })
            }

            context("When I scroll page to see second page data.") {
                let vm = ModelsMV(manufacturer: Manufacturer(id: "test_id", name: "test_name"), request: MockModelRequest.self)

                vm.loadMoreData()
                vm.loadMoreData()
                waitUntil(timeout: 1) { done in done() }

                it("Then, Second page data was loaded.", closure: {
                    expect(vm.isLoading).to(equal(false))
                })

                it("Then, Second page data was loaded successfully.", closure: {
                    expect(vm.hasLoadingError).to(equal(false))
                })

                it("Then, I can see second page data.", closure: {
                    expect(vm.currentPage).to(equal(2))
                })

                it("Then, Listed 15 model for second page.", closure: {
                    expect(vm.getItemCount(at: 1)).to(equal(15))
                })

                it("Then, Listed total 30 manufacturer on first and second page.", closure: {
                    expect(vm.getItemCount(at: 0) + vm.getItemCount(at: 1)).to(equal(30))
                })

                it("Then, There is a next page to will be loaded.", closure: {
                    expect(vm.hasNextPage).to(equal(true))
                })

                it("Then, There are 3 page to will be loaded.", closure: {
                    expect(vm.totalPageCount - vm.currentPage).to(equal(1))
                })
            }

            context("When I scroll page to end of screen") {
                let vm = ModelsMV(manufacturer: Manufacturer(id: "test_id", name: "test_name"), request: MockModelRequest.self)

                vm.loadMoreData()
                vm.loadMoreData()
                vm.loadMoreData()
                vm.loadMoreData()
                vm.loadMoreData()

                waitUntil(timeout: 1) { done in done() }

                it("Then, last page data was loaded.", closure: {
                    expect(vm.isLoading).to(equal(false))
                })

                it("Then, last page data was loaded successfully.", closure: {
                    expect(vm.hasLoadingError).to(equal(false))
                })

                it("Then, I can see last page data.", closure: {
                    expect(vm.currentPage).to(equal(3))
                })

                it("Then, Listed 12 model for last page.", closure: {
                    expect(vm.getItemCount(at: 2)).to(equal(8))
                })

                it("Then, Listed total 72 model on last page.", closure: {
                    expect(vm.getItemCount(at: 0) + vm.getItemCount(at: 1) + vm.getItemCount(at: 2) + vm.getItemCount(at: 3)).to(equal(38))
                })

                it("Then, There is no next page to be loaded.", closure: {
                    expect(vm.hasNextPage).to(equal(false))
                })

                it("Then, There are no page to will be loaded.", closure: {
                    expect(vm.totalPageCount - vm.currentPage).to(equal(0))
                })
            }

            context("When error is occurred on network or data") {
                let vm = ModelsMV(manufacturer: Manufacturer(id: "test_id", name: "test_name"), request: MockModelErrorProducerRequest.self)
                vm.loadMoreData()
                waitUntil(timeout: 1) { done in done() }

                it("Then, there is an error.", closure: {
                    expect(vm.hasLoadingError).to(equal(true))
                })

                it("Then, there is empty data.", closure: {
                    expect(vm.getItemCount(at: 0)).to(equal(0))
                })
                
                it("Then, reload data", closure: {
                   let vm = ModelsMV(manufacturer: Manufacturer(id: "test_id", name: "test_name"), request: MockModelRequest.self)
                    vm.loadingErrorMessage = "some error"
                    vm.reloadData()
                    waitUntil(timeout: 1) { done in done() }
                    
                    expect(vm.getItemCount(at: 0)).to(equal(15))
                    expect(vm.hasLoadingError).to(equal(false))
                    expect(vm.loadingErrorMessage).to(beNil())
                })
            }

            context("When I select Toyota") {
                let manufacturer = Manufacturer(id: "test_id", name: "test_name")
                let vm = ModelsMV(manufacturer: manufacturer, request: MockModelRequest.self)
                let router = MockModelRouter()
                vm.loadMoreData()
                vm.loadMoreData()
                vm.loadMoreData()
                vm.loadMoreData()
                vm.loadMoreData()
                waitUntil(timeout: 1) { done in done() }

                router.onModelSelected(manufacturer: manufacturer, model: vm.getItem(page: 2, index: 5)!)

                it("Then, Models page is initialized with Toyota") {
                    expect(router.message).to(equal("test_name, Yaris"))
                }
            }
        }
    }
}

fileprivate struct MockModelRequest: ModelRequestType {
    let page: Int
    init(manufacturerId: String, page: Int, pageSize: Int) {
        self.page = page
    }

    func execute(succeed: @escaping (PagedItemsResponse) -> Void, failed: @escaping (ErrorResponse) -> Void) -> URLSessionTask? {
        let fileName = "get_success_car_types_\(page).json"
        if let pagedResponse: PagedItemsResponse = readTestFile(JSONfile: fileName) {
            succeed(pagedResponse)
        } else {
            failed(ErrorResponse(with: .nilData, httpStatus: .notImplemented))
        }
        return nil
    }
}

fileprivate struct MockModelErrorProducerRequest: ModelRequestType {
    init(manufacturerId: String, page: Int, pageSize: Int) {
    }

    func execute(succeed: @escaping (PagedItemsResponse) -> Void, failed: @escaping (ErrorResponse) -> Void) -> URLSessionTask? {
        failed(ErrorResponse(with: .notConnectedToInternet, httpStatus: .badRequest))
        return nil
    }
}

fileprivate class MockModelRouter: ModelsRouterType {
    var message: String?
    func onModelSelected(manufacturer: Manufacturer, model: AutoModel) {
        message = "\(manufacturer.name), \(model.name)"
    }
}

