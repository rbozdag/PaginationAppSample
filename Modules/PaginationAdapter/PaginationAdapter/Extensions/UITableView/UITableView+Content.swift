//
//  UITableView+Content.swift
//  AutoCodingAssignment
//
//  Created by Rahmi Bozdağ on 16.02.2019.
//  Copyright © 2019 Rahmi Bozdag. All rights reserved.
//

import Foundation
import UIKit

public extension UITableView {
    var visiblePartOfTableView: CGRect {
        return CGRect(
            x: self.contentOffset.x,
            y: self.contentOffset.y,
            width: self.bounds.size.width,
            height: self.bounds.size.height
        )
    }
    
    var totalRowCount: Int {
        return (0..<numberOfSections).reduce(0, { return $0 + numberOfRows(inSection: $1) })
    }
    
    func getOrder(of path: IndexPath) -> Int {
        if path.section == 0 {
            return path.row
        }
        return (0...(path.section - 1)).reduce(path.row, { return $0 + numberOfRows(inSection: $1) })
    }
}

