//
//  AppStoreRequirement.swift
//  myAppSearch
//
//  Created by 김희수 on 2023/03/20.
//

import Foundation
import Combine

protocol AppStoreRequirement {
    func requestSearch(keyword: String) -> AnyPublisher<AppStoreSearchApiResponse, TraceError>
    func cancelSearch()
}

extension AppStoreRequirement {
    func requestSearch(keyword: String) -> AnyPublisher<AppStoreSearchApiResponse, TraceError> {
        let fail = Fail<AppStoreSearchApiResponse, TraceError>(error: TraceError(message: "not implemented"))
        return fail.eraseToAnyPublisher()
    }
    
    func cancelSearch() {
        Log.Debug(.DOMAIN, "not implemented")
    }
}
