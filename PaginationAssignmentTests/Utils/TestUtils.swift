//
//  TestUtils.swift
//  PaginationAssignmentTests
//
//  Created by Rahmi Bozdağ on 16.02.2019.
//  Copyright © 2019 Rahmi Bozdag. All rights reserved.
//

import Foundation

func readTestFile<T:Decodable>(JSONfile: String) -> T? {
    if let path = Bundle.main.path(forResource: JSONfile, ofType: nil) {
        do {
            if let contentJson = try? String(contentsOfFile: path) {
                if let data = contentJson.data(using: .utf8) {
                    do {
                        let instance = try? JSONDecoder().decode(T.self, from: data)
                        return instance
                    }
                }
            }
        }
    }
    return nil
}
