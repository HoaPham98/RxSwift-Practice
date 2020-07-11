//
//  RecipeInfoViewModel.swift
//  Delicious
//
//  Created by HoaPQ on 7/9/20.
//  Copyright © 2020 HoaPQ. All rights reserved.
//

import RxSwift
import RxCocoa
import MGArchitecture

struct RecipeInfoViewModel {
    let navigator: RecipeInfoNavigatorType
    let useCase: RecipeInfoUseCaseType
}

extension RecipeInfoViewModel: ViewModelType {
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    func transform(_ input: RecipeInfoViewModel.Input) -> RecipeInfoViewModel.Output {
        return Output()
    }
}
