//
//  ShopingListViewModel.swift
//  Delicious
//
//  Created by HoaPQ on 7/14/20.
//  Copyright © 2020 HoaPQ. All rights reserved.
//

import Foundation
import RxDataSources

typealias ShopingListSectionModel = SectionModel<ShopingList, ShortIngredient>

struct ShopingListViewModel {
    let navigator: ShopingListNavigatorType
    let useCase: ShopingListUseCaseType
}

extension ShopingListViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
        let reloadTrigger: Driver<Void>
        let selectedTrigger: Driver<IndexPath>
        let selectedTitleTrigger: Driver<RecipeType>
        let deleteTrigger: Driver<ShopingList>
    }
    
    struct Output {
        let data: Driver<[ShopingListSectionModel]>
        let isLoading: Driver<Bool>
        let isReloading: Driver<Bool>
        let error: Driver<Error>
        let selected: Driver<Void>
        let selectedTitle: Driver<Void>
        let deleted: Driver<Void>
    }
    
    func transform(_ input: ShopingListViewModel.Input) -> ShopingListViewModel.Output {
        
        let error = ErrorTracker()

        let getRecipe = getItem(
            loadTrigger: input.loadTrigger,
            reloadTrigger: input.reloadTrigger) { _ in
                return self.useCase
                    .getShopingListRecipes()
                    .trackError(error)
        }
        let lists = getRecipe.item.map { list in
            list.map { ShopingListSectionModel(model: $0, items: $0.ingredients) }
        }
        
        let selected = input.selectedTrigger.withLatestFrom(getRecipe.item) { (index, lists) -> (Int, ShopingList) in
            return (index.row, lists[index.section])
        }.flatMapLatest { (index, list) -> Driver<Void> in
            var list = list
            var ingredients = list.ingredients
            let isDone = list.ingredients[index].isDone
            ingredients[index].isDone = !isDone
            list.ingredients = ingredients
            return self.useCase.update(list: list).asDriverOnErrorJustComplete()
        }
        
        let selectedTitle = input.selectedTitleTrigger.do(onNext: { recipe in
            self.navigator.toInformation(recipe: recipe)
        }).mapToVoid()
        
        let deleted = input.deleteTrigger.flatMapLatest {
            self.navigator
                .showDeletionConfirm(list: $0)
                .trackError(error)
                .asDriverOnErrorJustComplete()
        }.flatMapLatest {
            self.useCase
                .remove(list: $0)
                .trackError(error)
                .asDriverOnErrorJustComplete()
        }
        
        return Output(
            data: lists,
            isLoading: getRecipe.isLoading,
            isReloading: getRecipe.isReloading,
            error: error.asDriver(),
            selected: selected,
            selectedTitle: selectedTitle,
            deleted: deleted
        )
    }
}
