//
//  localized.swift
//  PaginationAssignment
//
//  Created by Rahmi Bozdağ on 16.02.2019.
//  Copyright © 2019 Rahmi Bozdag. All rights reserved.
//

import Foundation

public extension String {
    public func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
}
