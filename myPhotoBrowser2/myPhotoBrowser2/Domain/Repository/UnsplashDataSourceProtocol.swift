//
//  UnsplashDataSourceProtocol.swift
//  myPhotoBrowser2
//
//  Created by 김희수 on 2022/04/29.
//

import Combine

protocol UnsplashDataSourceProtocol {
    func getPhotoList(pageNumber: Int) -> AnyPublisher<[PhotoInfo], TraceError>
    func getPhotoDetail(id: String) -> AnyPublisher<PhotoDetail, TraceError>
    func getSearchResult(keyword: String, pageNumber: Int) -> AnyPublisher<[PhotoInfo], TraceError>
}
