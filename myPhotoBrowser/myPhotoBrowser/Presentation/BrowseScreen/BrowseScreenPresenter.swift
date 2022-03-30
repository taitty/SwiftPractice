//
//  BrowseScreenPresenter.swift
//  myPhotoBrowser
//
//  Created by 김희수 on 2022/03/30.
//

import Foundation

protocol BrowseScreenPresenterProtocol {
    func cellSelected(id: String?)
}

final class BrowseScreenPresenter {
    
    var interactor: BrowseScreenInteractorProtocol?
    var wireframe: BrowseScreenWireframeProtocol?
}

extension BrowseScreenPresenter: BrowseScreenPresenterProtocol {
    
    func cellSelected(id: String?) {
        wireframe?.routeToDetailScreen(content: id)
    }
}
