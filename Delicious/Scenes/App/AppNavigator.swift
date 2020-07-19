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
        
        // MARK: Favorite
        let favoriteVC = FavoriteViewController.instantiate()
        let navFavorite = CustomNavigationController(rootViewController: favoriteVC).then {
            $0.tabBarItem = UITabBarItem(title: "Favorite", image: Icon.icFavoriteSelected, selectedImage: Icon.icFavoriteSelectedOrange)
        }
        let favoriteNavigator = FavoriteNavigator(navigationController: navFavorite)
        let favoriteUseCase = FavoriteUseCase()
        let favoriteViewModel = FavoriteViewModel(navigator: favoriteNavigator, useCase: favoriteUseCase)
        favoriteVC.bindViewModel(to: favoriteViewModel)
        
        // MARK: Shoping List
        let shopingListVC = ShopingListViewController.instantiate()
        let navShopingList = CustomNavigationController(rootViewController: shopingListVC).then {
            $0.tabBarItem = UITabBarItem(title: "Shoping List", image: Icon.icShoping, selectedImage: Icon.icShopingSelected)
        }
        let shopingListNavigator = ShopingListNavigator(navigationController: navShopingList)
        let shopingListUseCase = ShopingListUseCase()
        let shopingListViewModel = ShopingListViewModel(navigator: shopingListNavigator, useCase: shopingListUseCase)
        shopingListVC.bindViewModel(to: shopingListViewModel)
        
        tabbar.viewControllers = [navHome, navFavorite, navShopingList]
        
        window.rootViewController = tabbar
    }
}
