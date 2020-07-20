//
//  RecipeInfoUseCase.swift
//  Delicious
//
//  Created by HoaPQ on 7/9/20.
//  Copyright © 2020 HoaPQ. All rights reserved.
//

import RxSwift

protocol RecipeInfoUseCaseType {
    func getRecipe(id: Int) -> Observable<RecipeInformation>
    func addToShopingList(recipe: RecipeInformation) -> Observable<Void>
    func addToShopingList(recipe: RecipeInformation, type: RecipeType) -> Observable<Void>
    func updateFavorite(recipe: RecipeType, status: Bool) -> Observable<Void>
    func checkFavorite(recipe: RecipeType) -> Observable<Bool>
    func checkShoping(recipe: RecipeType) -> Observable<Bool>
}

struct RecipeInfoUseCase: RecipeInfoUseCaseType {
    func getRecipe(id: Int) -> Observable<RecipeInformation> {
        let repository = HomeRepositoy()
        let request = RecipeInfoRequest(id: id)
        return repository.getRecipeInfomation(input: request)
    }
    
    func addToShopingList(recipe: RecipeInformation, type: RecipeType) -> Observable<Void> {
        var recipe = recipe
        recipe.id = type.id
        recipe.title = type.title
        return ShopingListRepository().add(ShopingList(from: recipe))
    }
    
    func addToShopingList(recipe: RecipeInformation) -> Observable<Void> {
        return ShopingListRepository().add([ShopingList(from: recipe)])
    }
    
    func updateFavorite(recipe: RecipeType, status: Bool) -> Observable<Void> {
        let repository = FavoriteRepository()
        if status {
            return repository.add([recipe.mapToFavorite()])
        } else {
            return repository.deleteItem(havingID: recipe.id)
        }
    }
    
    func checkFavorite(recipe: RecipeType) -> Observable<Bool> {
        let repository = FavoriteRepository()
        return repository.item(havingID: recipe.id).map { $0 != nil }
    }
    
    func checkShoping(recipe: RecipeType) -> Observable<Bool> {
        return ShopingListRepository().item(havingID: recipe.id).map { $0 != nil }
    }
}
