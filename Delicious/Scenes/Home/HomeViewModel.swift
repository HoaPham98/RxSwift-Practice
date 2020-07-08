//
//  HomeViewModel.swift
//  Delicious
//
//  Created by HoaPQ on 7/8/20.
//  Copyright © 2020 HoaPQ. All rights reserved.
//

import RxSwift
import RxCocoa
import MGArchitecture

struct HomeViewModel {
    let navigator: HomeNavigatorType
    let useCase: HomeUseCaseType
}

extension HomeViewModel: ViewModelType {
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    func transform(_ input: HomeViewModel.Input) -> HomeViewModel.Output {
        return Output()
    }
}
