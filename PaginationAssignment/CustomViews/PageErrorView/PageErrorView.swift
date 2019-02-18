//
//  PageErrorView.swift
//  PaginationAssignment
//
//  Created by Rahmi Bozdağ on 16.02.2019.
//  Copyright © 2019 Rahmi Bozdag. All rights reserved.
//

import Foundation
import UIKit

class PageErrorView: UIView, NibLoadableView {
    @IBOutlet private weak var errorMessageLabel: UILabel!
    var reloadAction: (() -> Void)?

    func setError(message: String?) {
        errorMessageLabel.text = message
    }

    @IBAction private func reload() {
        reloadAction?()
    }
}
