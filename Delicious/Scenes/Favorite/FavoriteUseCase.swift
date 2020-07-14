//
//  FavoriteUseCase.swift
//  Delicious
//
//  Created by HoaPQ on 7/14/20.
//  Copyright © 2020 HoaPQ. All rights reserved.
//

import RxSwift

protocol FavoriteUseCaseType {
    func getFavoriteRecipes() -> Observable<[FavoriteRecipe]>
}

struct FavoriteUseCase: FavoriteUseCaseType {
    
    func getFavoriteRecipes() -> Observable<[FavoriteRecipe]> {
        return FavoriteRepository().getFavoriteRecipes()
    }
}
