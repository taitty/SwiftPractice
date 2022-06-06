//
//  GetSearchDataUseCase.swift
//  myPhotoBrowser2
//
//  Created by 김희수 on 2022/04/29.
//

import Combine

struct GetSearchDataUseCase {
    
    private let dataSource: UnsplashDataSourceProtocol
    private let keyword: String
    private let page: Int
    
    init(dataSource: UnsplashDataSourceProtocol, keyword: String, page: Int) {
        Log.Debug(.DOMAIN, "")
        self.dataSource = dataSource
        self.keyword = keyword
        self.page = page
    }
    
    func execute() -> AnyPublisher<[PhotoInfo], TraceError> {
        return dataSource.getSearchResult(keyword: keyword, pageNumber: page)
    }
    
}
