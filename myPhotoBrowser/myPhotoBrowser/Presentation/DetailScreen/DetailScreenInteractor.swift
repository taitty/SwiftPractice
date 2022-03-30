//
//  DetailScreenInteractor.swift
//  myPhotoBrowser
//
//  Created by 김희수 on 2022/03/30.
//

import Foundation

protocol DetailScreenInteractorProtocol {}

final class DetailScreenInteractor {
    
    var dataSource: UnsplashDataSourceProtocol?
    var contentId: String?
}

extension DetailScreenInteractor: DetailScreenInteractorProtocol {}
