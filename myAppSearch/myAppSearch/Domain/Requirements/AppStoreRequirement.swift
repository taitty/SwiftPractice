//
//  AppStoreRequirement.swift
//  myAppSearch
//
//  Created by 김희수 on 2023/03/20.
//

import Foundation
import Combine

protocol AppStoreRequirement {
    func requestSearch(keyword: String) -> AnyPublisher<[AppInfo], TraceError>
}

extension AppStoreRequirement {
    func requestSearch(keyword: String) -> AnyPublisher<[AppInfo], TraceError> {
        let fail = Fail<[AppInfo], TraceError>(error: TraceError(message: "not implemented"))
        return fail.eraseToAnyPublisher()
    }
}
