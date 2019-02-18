//
//  Array+Extensions.swift
//  PaginationAssignment
//
//  Created by Rahmi Bozdağ on 16.02.2019.
//  Copyright © 2019 Rahmi Bozdag. All rights reserved.
//

import Foundation

public extension Array {
    public subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
