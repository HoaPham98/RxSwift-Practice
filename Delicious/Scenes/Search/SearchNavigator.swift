//
//  SearchNavigator.swift
//  Delicious
//
//  Created by HoaPQ on 7/16/20.
//  Copyright © 2020 HoaPQ. All rights reserved.
//

import Foundation

protocol SearchNavigatorType {
    // TODO: Add go to information?
    func showDeletionConfirm(list: ShopingList) -> Observable<ShopingList>
}

struct SearchNavigator: SearchNavigatorType {
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
