//
//  DetailScreenPresenter.swift
//  myPhotoBrowser
//
//  Created by 김희수 on 2022/03/30.
//

import Foundation

final class DetailScreenPresenter {
    
    private let interactor: DetailScreenInteractor
    private let wireframe: DetailScreenWireframe

    init(interactor: DetailScreenInteractor, wireframe: DetailScreenWireframe) {
        self.interactor = interactor
        self.wireframe = wireframe
    }
    
    func pressInfoButton(contentId: String) {
        wireframe.routeToInfoScreen(id: contentId)
    }
    
    func pressCloseButton() {
        wireframe.routeToBrowseScreen()
    }
}
