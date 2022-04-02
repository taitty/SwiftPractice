//
//  DetailScreenPresenter.swift
//  myPhotoBrowser
//
//  Created by 김희수 on 2022/03/30.
//

import Foundation

protocol DetailScreenPresenterProtocol {
    func pressInfoButton(contentId: String)
    func pressCloseButton()
}

final class DetailScreenPresenter {
    
    var interactor: DetailScreenInteractorProtocol?
    var wireframe: DetailScreenWireframeProtocol?
}

extension DetailScreenPresenter: DetailScreenPresenterProtocol {
    
    func pressInfoButton(contentId: String) {
        wireframe?.routeToInfoScreen(id: contentId)
    }
    
    func pressCloseButton() {
        wireframe?.routeToBrowseScreen()
    }
}
