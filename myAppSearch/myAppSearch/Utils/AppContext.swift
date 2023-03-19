//
//  AppContext.swift
//  myAppSearch
//
//  Created by 김희수 on 2023/03/20.
//

import Foundation

enum AppContext {
    case test
    case real
    
    var dataSource: AppStoreRequirement {
        switch self {
        case .real:
            return AppStoreDataSource()
        case .test:
            return MockAppStoreDataSource()
        }
    }
}
