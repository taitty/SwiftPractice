//
//  GetHomeDataUseCase.swift
//  myPhotoBrowser2
//
//  Created by 김희수 on 2022/04/29.
//

import Combine

struct GetHomeDataUseCase {
    
    private let dataSource: UnsplashDataSourceProtocol
    private let page: Int
    
    init(dataSource: UnsplashDataSourceProtocol, page: Int) {
        Log.Debug(.DOMAIN, "")
        self.dataSource = dataSource
        self.page = page
    }
    
    func execute() -> AnyPublisher<[PhotoInfo], TraceError> {
        return dataSource.getPhotoList(pageNumber: page)
    }
    
}
