//
//  DetailScreenInteractor.swift
//  myPhotoBrowser
//
//  Created by 김희수 on 2022/03/30.
//

import Foundation

final class DetailScreenInteractor {
    
    private let dataSource: UnsplashDataSourceProtocol
    
    init(dataSource: UnsplashDataSourceProtocol) {
        self.dataSource = dataSource
    }
    
}
