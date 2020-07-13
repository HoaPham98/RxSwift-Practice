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
    func addToShopingList()
    func updateFavorite(recipe: RecipeType, status: Bool)
}

struct RecipeInfoUseCase: RecipeInfoUseCaseType {
    func getRecipe(id: Int) -> Observable<RecipeInformation> {
        let repository = HomeRepositoy()
        let request = RecipeInfoRequest(id: id)
        return repository.getRecipeInfomation(input: request)
    }
    
    func addToShopingList() {
        
    }
    
    func updateFavorite(recipe: RecipeType, status: Bool) {
        
    }
}
