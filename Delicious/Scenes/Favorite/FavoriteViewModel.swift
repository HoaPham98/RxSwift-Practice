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
        let reloadTrigger: Driver<Void>
        let deletedTrigger: Driver<FavoriteRecipe>
        let selectedTrigger: Driver<FavoriteRecipe>
    }
    
    struct Output {
        let data: Driver<[FavoriteRecipe]>
        let isLoading: Driver<Bool>
        let isReloading: Driver<Bool>
        let error: Driver<Error>
        let selected: Driver<Void>
        let deleted: Driver<Void>
    }
    
    func transform(_ input: FavoriteViewModel.Input) -> FavoriteViewModel.Output {
        
        let error = ErrorTracker()

        let recipe = getItem(
            loadTrigger: input.loadTrigger,
            reloadTrigger: input.reloadTrigger) { _ in
                return self.useCase
                    .getFavoriteRecipes()
                    .trackError(error)
        }
        
        let selected = input.selectedTrigger
            .do(onNext: { self.navigator.toInfomation(recipe: $0) })
            .mapToVoid()
        
        let deleted = input.deletedTrigger.flatMapLatest {
            self.useCase
                .remove(recipe: $0)
                .trackError(error)
                .asDriverOnErrorJustComplete()
        }
        
        return Output(
            data: recipe.item,
            isLoading: recipe.isLoading,
            isReloading: recipe.isReloading,
            error: error.asDriver(),
            selected: selected,
            deleted: deleted
        )
    }
}
