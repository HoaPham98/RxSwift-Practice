//
//  FavoriteViewModel.swift
//  Delicious
//
//  Created by HoaPQ on 7/14/20.
//  Copyright © 2020 HoaPQ. All rights reserved.
//

import Foundation

struct FavoriteViewModel {
    let navigator: FavoriteNavigatorType
    let useCase: FavoriteUseCaseType
}

extension FavoriteViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
        let selectedTrigger: Driver<FavoriteRecipe>
        let deletedTrigger: Driver<FavoriteRecipe>
    }
    
    struct Output {
        let recipes: Driver<[FavoriteRecipe]>
        let selected: Driver<Void>
    }
    
    func transform(_ input: FavoriteViewModel.Input) -> FavoriteViewModel.Output {
        
        let recipes = input.loadTrigger.flatMapLatest { _ in
            return self.useCase
                .getFavoriteRecipes()
                .asDriverOnErrorJustComplete()
        }
        
        let selected = input.selectedTrigger
            .do(onNext: { self.navigator.toInfomation(recipe: $0) })
            .mapToVoid()
        
        return Output(
            recipes: recipes,
            selected: selected
        )
    }
}
