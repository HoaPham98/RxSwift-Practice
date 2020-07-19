//
//  ShopingListUseCase.swift
//  Delicious
//
//  Created by HoaPQ on 7/14/20.
//  Copyright © 2020 HoaPQ. All rights reserved.
//

import RxSwift

protocol ShopingListUseCaseType {
    func getShopingListRecipes() -> Observable<[ShopingList]>
    func remove(list: ShopingList) -> Observable<Void>
    func update(list: ShopingList) -> Observable<Void>
}

struct ShopingListUseCase: ShopingListUseCaseType {
    
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
