//
//  UITableView+Header.swift
//  PaginationAssignment
//
//  Created by Rahmi Bozdağ on 16.02.2019.
//  Copyright © 2019 Rahmi Bozdag. All rights reserved.
//

import Foundation
import UIKit

public extension UITableView {
    public func isVisibleHeader(section: Int) -> Bool {
        guard numberOfSections > section else {
            return false
        }

        let headerRect = self.rectForHeader(inSection: section)
        
        return visiblePartOfTableView.intersects(headerRect)
    }
}
