//
//  ModelsRouter.swift
//  PaginationAssignment
//
//  Created by Rahmi Bozdağ on 16.02.2019.
//  Copyright © 2019 Rahmi Bozdag. All rights reserved.
//

import Foundation
import UIKit

protocol ModelsRouterType {
    func onModelSelected(manufacturer: Manufacturer, model: AutoModel)
}

class ModelsRouter: ModelsRouterType {
    weak var navigationController: UINavigationController?
    
    init(with navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }

    func onModelSelected(manufacturer: Manufacturer, model: AutoModel) {
        let message = "\(manufacturer.name), \(model.name)"
        let alertView = UIAlertController(title: "Selected Manufacture, Model", message: message, preferredStyle: UIAlertController.Style.alert)
        alertView.addAction(UIAlertAction(title: "ok.button.title".localized(), style: UIAlertAction.Style.default, handler: { _ in }))
        navigationController?.present(alertView, animated: true, completion: nil)
    }
}
