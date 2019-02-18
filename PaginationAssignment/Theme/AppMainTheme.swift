//
//  AppMainTheme.swift
//  PaginationAssignment
//
//  Created by Rahmi Bozdağ on 16.02.2019.
//  Copyright © 2019 Rahmi Bozdag. All rights reserved.
//

import Foundation
import UIKit

struct AppMainTheme {
    static var navigationBackButtonColor: UIColor!
    
    static func loadBlueTheme() {
        AppMainTheme.loadBlueThemeNavigaitionBarAppearance()
        navigationBackButtonColor = UIColor.white
    }
    
    static func loadBlueThemeNavigaitionBarAppearance() {
        UINavigationBar.appearance().barTintColor = UIColor.appBlueBlue
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UINavigationBar.appearance().isTranslucent = false
    }
}
