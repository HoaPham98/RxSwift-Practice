//
//  ShopingListNavigator.swift
//  Delicious
//
//  Created by HoaPQ on 7/14/20.
//  Copyright © 2020 HoaPQ. All rights reserved.
//

import UIKit

protocol ShopingListNavigatorType {
    // TODO: Add go to information?
    func showDeletionConfirm(list: ShopingList) -> Observable<ShopingList>
}

struct ShopingListNavigator: ShopingListNavigatorType {
    unowned let navigationController: UINavigationController
    
    func showDeletionConfirm(list: ShopingList) -> Observable<ShopingList> {
        let message = "Are you sure you want to remove this recipe from ShopingList?"
        return navigationController
            .showAlertView(title: "Remove confirm",
                           message: message,
                           style: .alert,
                           actions: [("Yes", .default),
                                     ("Cancel", .cancel)])
            .filter { $0 == 0 }
            .map { _ in list }
    }
}
