//
//  AutoCompletionRequest.swift
//  Delicious
//
//  Created by HoaPQ on 7/20/20.
//  Copyright © 2020 HoaPQ. All rights reserved.
//

import Foundation

class AutoCompletionRequest: BaseRequest {
    init(query: String) {
        let body = ["query": query, "number": 10] as [String : Any]
        super.init(url: URLs.API.autoCompletion,
                   requestType: .get,
                   body: body)
    }
}
