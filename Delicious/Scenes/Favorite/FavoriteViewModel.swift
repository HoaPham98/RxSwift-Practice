//
//  FavoriteViewModel.swift
//  Delicious
//
//  Created by HoaPQ on 7/14/20.
//  Copyright © 2020 HoaPQ. All rights reserved.
//

import Foundation
import RxDataSources

typealias RecipeListSectionModel = AnimatableSectionModel<String, FavoriteRecipe>

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
        let data: Driver<[RecipeListSectionModel]>
        let isLoading: Driver<Bool>
        let isReloading: Driver<Bool>
        let error: Driver<Error>
        let selected: Driver<Void>
        let deleted: Driver<Void>
    }
    
    func transform(_ input: FavoriteViewModel.Input) -> FavoriteViewModel.Output {
        
        let error = ErrorTracker()

        let getRecipe = getItem(
            loadTrigger: input.loadTrigger,
            reloadTrigger: input.reloadTrigger) { _ in
                return self.useCase
                    .getFavoriteRecipes()
                    .trackError(error)
        }
        let recipe = getRecipe.item.map { [RecipeListSectionModel(model: "", items: $0)] }
        
        let selected = input.selectedTrigger
            .do(onNext: { self.navigator.toInfomation(recipe: $0) })
            .mapToVoid()
        
        let deleted = input.deletedTrigger.flatMapLatest {
            self.navigator
                .showDeletionConfirm(recipe: $0)
                .trackError(error)
                .asDriverOnErrorJustComplete()
        }
        .flatMapLatest {
            self.useCase
                .remove(recipe: $0)
                .trackError(error)
                .asDriverOnErrorJustComplete()
        }
        
        return Output(
            data: recipe,
            isLoading: getRecipe.isLoading,
            isReloading: getRecipe.isReloading,
            error: error.asDriver(),
            selected: selected,
            deleted: deleted
        )
    }
}
