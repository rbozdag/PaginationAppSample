//
//  AppRouter.swift
//  PaginationAssignment
//
//  Created by Rahmi Bozdağ on 16.02.2019.
//  Copyright © 2019 Rahmi Bozdag. All rights reserved.
//

import Foundation
import UIKit

final class AppRouter {
    let window: UIWindow
    init() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
    }

    func start() {
        let manufacturersVC = createInitialVC()
        let navigationVC = UINavigationController(rootViewController: manufacturersVC)
        manufacturersVC.router = ManufacturersRouter(with: navigationVC)
        
        self.window.rootViewController = navigationVC
        self.window.makeKeyAndVisible()
    }

    private func createInitialVC() -> ManufacturersVC {
        let manufacturersVC = ManufacturersVC()
        manufacturersVC.viewModel = ManufacturersVM(request: ManufacturerRequest.self)
        return manufacturersVC
    }
}
