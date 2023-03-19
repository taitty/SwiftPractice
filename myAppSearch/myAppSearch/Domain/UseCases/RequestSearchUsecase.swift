//
//  RequestSearchUsecase.swift
//  myAppSearch
//
//  Created by 김희수 on 2023/03/20.
//

import Foundation
import Combine

struct RequestSearchUsecase {
    private let dataSource: AppStoreRequirement
    
    init(dataSource: AppStoreRequirement) {
        self.dataSource = dataSource
    }
    
    func execute(keyword: String) -> AnyPublisher<[AppInfo], TraceError> {
        Log.Debug(.DOMAIN, "keyword : \(keyword)")
        return dataSource.requestSearch(keyword: keyword)
    }
}
