//
//  SearchUseCase.swift
//  Delicious
//
//  Created by HoaPQ on 7/16/20.
//  Copyright © 2020 HoaPQ. All rights reserved.
//

import Foundation

protocol SearchUseCaseType {
    func getShopingListRecipes() -> Observable<[ShopingList]>
    func remove(list: ShopingList) -> Observable<Void>
    func update(list: ShopingList) -> Observable<Void>
}

struct SearchUseCase: ShopingListUseCaseType {
    
    func getShopingListRecipes() -> Observable<[ShopingList]> {
        return ShopingListRepository().getShopingLists()
    }
    
    func remove(list: ShopingList) -> Observable<Void> {
        return ShopingListRepository().deleteItem(havingID: list.id)
    }
    
    func update(list: ShopingList) -> Observable<Void> {
        return ShopingListRepository().update(list)
    }
}
