//
//  NibLoadableView+DefaultExtension.swift
//  PaginationAssignment
//
//  Created by Rahmi Bozdağ on 16.02.2019.
//  Copyright © 2019 Rahmi Bozdag. All rights reserved.
//

import Foundation
import UIKit

public extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }

    @discardableResult
    func attachNib() -> UIView {
        let view = Self.loadViewFromNib()
        view.frame = self.bounds
        addSubview(view)

        view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true

        return view
    }

    static func loadViewFromNib() -> Self {
        let nib = UINib(nibName: nibName, bundle: nil)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view as! Self
    }
}
