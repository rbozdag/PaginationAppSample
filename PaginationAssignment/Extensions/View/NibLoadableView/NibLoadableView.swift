//
//  NibLoadableView.swift
//  PaginationAssignment
//
//  Created by Rahmi Bozdağ on 16.02.2019.
//  Copyright © 2019 Rahmi Bozdag. All rights reserved.
//

import Foundation
import UIKit

public protocol NibLoadableView {
    func attachNib() -> UIView

    static var nibName: String { get }
    
    static func loadViewFromNib() -> Self
}

