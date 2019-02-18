//
//  RegisterableCell.swift
//  PaginationAssignment
//
//  Created by Rahmi Bozdağ on 16.02.2019.
//  Copyright © 2019 Rahmi Bozdag. All rights reserved.
//

import Foundation
import UIKit

public protocol RegisterableCell {
    static func register(to tableView: UITableView)
}
