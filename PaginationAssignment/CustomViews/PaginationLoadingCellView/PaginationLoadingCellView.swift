//
//  PaginationLoadingView.swift
//  PaginationAssignment
//
//  Created by Rahmi Bozdağ on 16.02.2019.
//  Copyright © 2019 Rahmi Bozdag. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView

class PaginationLoadingCellView: UITableViewCell, Reusable, NibLoadableView, RegisterableCell {
    @IBOutlet private weak var loadingAnimation: NVActivityIndicatorView! {
        didSet {
            loadingAnimation.startAnimating()
        }
    }
}
