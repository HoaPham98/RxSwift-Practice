//
//  AppNavigator.swift
//  Delicious
//
//  Created by HoaPQ on 7/7/20.
//  Copyright © 2020 HoaPQ. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol AppNavigatorType {
    func toMain()
}

struct AppNavigator: AppNavigatorType {
    unowned let window: UIWindow
    
    func toMain() {
        let viewController = AppTabbarController()
        let navigationController = UINavigationController(rootViewController: viewController)
        
        window.rootViewController = navigationController
    }
}
