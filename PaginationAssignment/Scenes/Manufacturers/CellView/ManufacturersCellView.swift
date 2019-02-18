//
//  ManifacturerCellView.swift
//  PaginationAssignment
//
//  Created by Rahmi Bozdağ on 16.02.2019.
//  Copyright © 2019 Rahmi Bozdag. All rights reserved.
//

import Foundation
import UIKit

class ManufacturersCellView: UITableViewCell, Reusable, NibLoadableView, RegisterableCell {
    static var reuseIdentifier: String { return String(describing: self) }

    @IBOutlet private weak var nameLabel: UILabel!

    func setName(_ name: String) {
        nameLabel.text = name
    }

    func clear() {
        nameLabel.text = nil
    }
}
