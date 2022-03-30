//
//  UnsplashDataSourceProtocol.swift
//  myPhotoBrowser
//
//  Created by 김희수 on 2022/03/30.
//

import Foundation

protocol UnsplashDataSourceProtocol {
    func getPhotoList() -> [PhotoInfo]
    func getPhotoDetail() -> PhotoDetail
    func getSearchResult() -> [PhotoInfo]
}
