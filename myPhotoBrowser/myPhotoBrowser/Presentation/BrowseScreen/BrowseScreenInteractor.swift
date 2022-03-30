//
//  BrowseScreenInteractor.swift
//  myPhotoBrowser
//
//  Created by 김희수 on 2022/03/30.
//

import Foundation

protocol BrowseScreenInteractorProtocol {}

final class BrowseScreenInteractor {
    
    var dataSource: UnsplashDataSourceProtocol?
}

extension BrowseScreenInteractor: BrowseScreenInteractorProtocol {}
