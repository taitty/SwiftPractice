//
//  MockAppStoreDataSource.swift
//  myAppSearch
//
//  Created by 김희수 on 2023/03/20.
//

import Foundation
import Combine

struct MockAppStoreDataSource: AppStoreRequirement {
    func requestSearch(keyword: String) -> AnyPublisher<[AppInfo], TraceError> {
        Log.Debug(.INFRA, "keyword : \(keyword)")
        
        let fail = Fail<[AppInfo], TraceError>(error: TraceError(message: "failed to create url request..."))
        return fail.eraseToAnyPublisher()
    }
}
