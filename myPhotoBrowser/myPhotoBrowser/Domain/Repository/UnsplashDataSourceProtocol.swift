//
//  UnsplashDataSourceProtocol.swift
//  myPhotoBrowser
//
//  Created by 김희수 on 2022/03/30.
//

import Foundation
import Combine

protocol UnsplashDataSourceProtocol {
    func getPhotoList() -> AnyPublisher<[PhotoInfo], TraceError>
    func getPhotoDetail(id: String) -> AnyPublisher<PhotoDetail, TraceError>
    func getSearchResult(keyword: String) -> AnyPublisher<[PhotoInfo], TraceError>
}
