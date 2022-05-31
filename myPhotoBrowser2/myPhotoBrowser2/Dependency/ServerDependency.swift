//
//  ServerDependency.swift
//  myPhotoBrowser
//
//  Created by 김희수 on 2022/03/30.
//

import Foundation

enum ServerContext {
    case real
    case mock
    
    var dataSource: UnsplashDataSourceProtocol {
        switch self {
        case .real:
            return UnsplashDataSource()
        case .mock:
            return MockUnsplashDataSource()
        }
    }
}
