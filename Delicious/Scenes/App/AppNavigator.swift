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
        let tabbar = UITabBarController()
        tabbar.tabBar.isTranslucent = false
        tabbar.tabBar.tintColor = .systemOrange
        
        // MARK: Home
        let homeVC = HomeViewController.instantiate()
        let navHome = CustomNavigationController(rootViewController: homeVC).then {
            $0.tabBarItem = UITabBarItem(title: "Home", image: Icon.icHomeNormal, selectedImage: Icon.icHomeSelected)
        }
        let homeNavigator = HomeNavigator(navigationController: navHome)
        let homeUseCase = HomeUseCase()
        let homeViewModel = HomeViewModel(navigator: homeNavigator, useCase: homeUseCase)
        homeVC.bindViewModel(to: homeViewModel)
        
        tabbar.viewControllers = [navHome]
        
        window.rootViewController = tabbar
    }
}
