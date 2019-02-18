//
//  Router.swift
//  PaginationAssignment
//
//  Created by Rahmi Bozdağ on 16.02.2019.
//  Copyright © 2019 Rahmi Bozdag. All rights reserved.
//

import Foundation
import UIKit

protocol ManufacturersRouterType {
    func onManufacturerSelected(with manufacturer: Manufacturer)
}

class ManufacturersRouter: ManufacturersRouterType {
    weak var navigationController: UINavigationController?

    init(with navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func onManufacturerSelected(with manufacturer: Manufacturer) {
        let modelVC = createModelsVC(with: manufacturer)
        self.navigationController?.pushViewController(modelVC, animated: true)
    }

    private func createModelsVC(with manufacturer: Manufacturer) -> ModelsVC {
        let modelVC = ModelsVC()
        modelVC.viewModel = ModelsMV(manufacturer: manufacturer, request: ModelRequest.self)
        modelVC.router = ModelsRouter(with: navigationController)

        return modelVC
    }
}
