//
//  CustomNavigationController.swift
//  Delicious
//
//  Created by HoaPQ on 7/9/20.
//  Copyright © 2020 HoaPQ. All rights reserved.
//

import UIKit

extension UINavigationController {
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .lightContent
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.setNeedsStatusBarAppearanceUpdate()
    }
}

class CustomNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self
        changeTitleColor()
        changeBackIcon()
        changeNavigationColor()
    }
    
    func changeTitleColor() {
        navigationBar.titleTextAttributes = [.font: UIFont(name: "Avenir Book", size: 20), .foregroundColor: UIColor.white]
    }
    
    func changeBackIcon() {
        let barAppearance =
            UINavigationBar.appearance(whenContainedInInstancesOf: [CustomNavigationController.self])
        barAppearance.backIndicatorImage = Icon.icBack
        barAppearance.backIndicatorTransitionMaskImage = Icon.icBack
        barAppearance.tintColor = .white
        barAppearance.shadowImage = UIImage()
    }

    func changeNavigationColor() {
        navigationBar.barTintColor = .systemOrange
    }
}

extension CustomNavigationController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        let item = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        viewController.navigationItem.backBarButtonItem = item
    }
}
