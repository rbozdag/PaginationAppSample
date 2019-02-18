//
//  BaseVC.swift
//  PaginationAssignment
//
//  Created by Rahmi Bozdağ on 16.02.2019.
//  Copyright © 2019 Rahmi Bozdag. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView

class BaseVC: UIViewController, NVActivityIndicatorViewable {
    lazy var pageErrorView: PageErrorView = PageErrorView.loadViewFromNib()
    override func viewDidLoad() {
        super.viewDidLoad()
        makeBackBarItemEmpty()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    func makeBackBarItemEmpty() {
        let barbuttonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        barbuttonItem.tintColor = AppMainTheme.navigationBackButtonColor
        navigationItem.backBarButtonItem = barbuttonItem
    }

    func showPageError(with message: String, reloadAction: @escaping () -> Void) {
        self.view.addSubview(pageErrorView)
        pageErrorView.reloadAction = reloadAction
        pageErrorView.setError(message: message)

        pageErrorView.translatesAutoresizingMaskIntoConstraints = false
        pageErrorView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        pageErrorView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        pageErrorView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16)
        pageErrorView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16)

        pageErrorView.heightAnchor.constraint(equalToConstant: 80)
    }

    func hidePageError() {
        guard pageErrorView.superview != nil else {
            return
        }
        pageErrorView.removeFromSuperview()
    }



}
