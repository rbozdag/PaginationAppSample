//
//  PaginationApiStub.swift
//  PaginationAssignment
//
//  Created by Rahmi Bozdağ on 16.02.2019.
//  Copyright © 2019 Rahmi Bozdag. All rights reserved.
//

import Foundation
import OHHTTPStubs

class PaginationApiStub {
    class func enable<T: AnyObject>(activator: T.Type) {
        stub(condition: isMethodGET() && isPath("/v1/car-types/manufacturer") && containsQueryParams(["page": "0"]), response: { _ in
            guard let path = OHPathForFile("get_success_manufacturer_page_0.json", activator) else {
                preconditionFailure("Could not find expected file in test bundle")
            }
            sleep(1)
            return OHHTTPStubsResponse(fileAtPath: path, statusCode: 200, headers: ["Content-Type": "application/json"])
        })

        stub(condition: isMethodGET() && isPath("/v1/car-types/manufacturer") && containsQueryParams(["page": "1"]), response: { _ in
            guard let path = OHPathForFile("get_success_manufacturer_page_1.json", activator) else {
                preconditionFailure("Could not find expected file in test bundle")
            }
            sleep(1)
            return OHHTTPStubsResponse(fileAtPath: path, statusCode: 200, headers: ["Content-Type": "application/json"])
        })

        stub(condition: isMethodGET() && isPath("/v1/car-types/manufacturer") && containsQueryParams(["page": "2"]), response: { _ in
            guard let path = OHPathForFile("get_success_manufacturer_page_2.json", activator) else {
                preconditionFailure("Could not find expected file in test bundle")
            }

            sleep(1)
            return OHHTTPStubsResponse(fileAtPath: path, statusCode: 200, headers: ["Content-Type": "application/json"])
        })

        stub(condition: isMethodGET() && isPath("/v1/car-types/manufacturer") && containsQueryParams(["page": "3"]), response: { _ in
            guard let path = OHPathForFile("get_success_manufacturer_page_3.json", activator) else {
                preconditionFailure("Could not find expected file in test bundle")
            }

            sleep(1)

            return OHHTTPStubsResponse(fileAtPath: path, statusCode: 200, headers: ["Content-Type": "application/json"])
        })

        stub(condition: isMethodGET() && isPath("/v1/car-types/manufacturer") && containsQueryParams(["page": "4"]), response: { _ in
            guard let path = OHPathForFile("get_success_manufacturer_page_4.json", activator) else {
                preconditionFailure("Could not find expected file in test bundle")
            }

            sleep(1)

            return OHHTTPStubsResponse(fileAtPath: path, statusCode: 200, headers: ["Content-Type": "application/json"])
        })
        
        stub(condition: isMethodGET() && isPath("/v1/car-types/main-types")  && containsQueryParams(["page": "0"]), response: { _ in
            guard let path = OHPathForFile("get_success_car_types_0.json", activator) else {
                preconditionFailure("Could not find expected file in test bundle")
            }
            
            sleep(1)
            
            return OHHTTPStubsResponse(fileAtPath: path, statusCode: 200, headers: ["Content-Type": "application/json"])
        })
        
        stub(condition: isMethodGET() && isPath("/v1/car-types/main-types")  && containsQueryParams(["page": "1"]), response: { _ in
            guard let path = OHPathForFile("get_success_car_types_1.json", activator) else {
                preconditionFailure("Could not find expected file in test bundle")
            }
            
            sleep(1)
            
            return OHHTTPStubsResponse(fileAtPath: path, statusCode: 200, headers: ["Content-Type": "application/json"])
        })
        
        stub(condition: isMethodGET() && isPath("/v1/car-types/main-types")  && containsQueryParams(["page": "2"]), response: { _ in
            guard let path = OHPathForFile("get_success_car_types_2.json", activator) else {
                preconditionFailure("Could not find expected file in test bundle")
            }
            
            sleep(1)
            
            return OHHTTPStubsResponse(fileAtPath: path, statusCode: 200, headers: ["Content-Type": "application/json"])
        })
    }
}
