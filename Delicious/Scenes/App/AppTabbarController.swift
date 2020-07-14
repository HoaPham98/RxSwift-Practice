//
//  AppTabbarController.swift
//  Delicious
//
//  Created by HoaPQ on 7/14/20.
//  Copyright © 2020 HoaPQ. All rights reserved.
//

import Foundation
import UIKit

class AppTabbarController: UITabBarController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.do {
            $0.isTranslucent = false
            $0.tintColor = .systemOrange
        }
        
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    private func configViews() {
        // MARK: Home
        guard let navigationController = navigationController else { return }
        let homeVC = HomeViewController.instantiate().then {
            $0.tabBarItem = UITabBarItem(title: "Home", image: Icon.icHomeNormal, selectedImage: Icon.icHomeSelected)
        }
        let homeNavigator = HomeNavigator(navigationController: navigationController)
        let homeUseCase = HomeUseCase()
        let homeViewModel = HomeViewModel(navigator: homeNavigator, useCase: homeUseCase)
        homeVC.bindViewModel(to: homeViewModel)
        
        // MARK: Favorite
        let favoriteVC = FavoriteViewController.instantiate()
        
        viewControllers = [homeVC]
    }
}
