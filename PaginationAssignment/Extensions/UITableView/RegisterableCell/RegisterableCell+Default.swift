//
//  RegisterableCell+Default.swift
//  PaginationAssignment
//
//  Created by Rahmi Bozdağ on 16.02.2019.
//  Copyright © 2019 Rahmi Bozdag. All rights reserved.
//

import Foundation
import UIKit

public extension RegisterableCell where Self: Reusable&NibLoadableView {

    static func register(to tableView: UITableView) {
        tableView.register(getNib(), forCellReuseIdentifier: Self.reuseIdentifier)
    }

    private static func getNib() -> UINib {
        return UINib(nibName: Self.nibName, bundle: nil)
    }

}

