//
//  GetDetailDataUseCase.swift
//  myPhotoBrowser2
//
//  Created by 김희수 on 2022/04/29.
//

import Combine

struct GetDetailDataUseCase {
    
    private let dataSource: UnsplashDataSourceProtocol
    private let id: String
    
    init(dataSource: UnsplashDataSourceProtocol, photoId: String) {
        Log.Debug(.DOMAIN, "")
        self.dataSource = dataSource
        self.id = photoId
    }
    
    func execute() -> AnyPublisher<PhotoDetail, TraceError> {
        return dataSource.getPhotoDetail(id: id)
    }
    
}
