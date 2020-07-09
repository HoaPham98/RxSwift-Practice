//
//  HomeRepositoy.swift
//  Delicious
//
//  Created by HoaPQ on 7/8/20.
//  Copyright © 2020 HoaPQ. All rights reserved.
//

import RxSwift

protocol HomeRespositoryType {
    func getHomeData(input: HomeRequest) -> Observable<[RecipeInformation]>
}

struct HomeRepositoy: HomeRespositoryType {
    private let api = APIService.share
    
    func getHomeData(input: HomeRequest) -> Observable<[RecipeInformation]> {
        return api.request(input: input).map { (response: HomeResponse) in
            return response.recipes
        }
    }
}
