//
//  SearchRequest.swift
//  Delicious
//
//  Created by HoaPQ on 7/20/20.
//  Copyright © 2020 HoaPQ. All rights reserved.
//

import Foundation

class SearchRequest: BaseRequest {
    init(query: String, tags: [SearchTag]) {
        var body = ["query": query]
        tags.forEach {
            switch $0 {
            case .cuisine(let text):
                body["cuisine"] = text
            case .diet(let text):
                body["diet"] = text
            case .type(let text):
                body["type"] = text
            default:
                break
            }
        }
        super.init(url: URLs.API.searchUrl, requestType: .get, body: body)
    }
}
