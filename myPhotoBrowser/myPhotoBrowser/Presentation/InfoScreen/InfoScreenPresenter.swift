//
//  InfoScreenPresenter.swift
//  myPhotoBrowser
//
//  Created by 김희수 on 2022/03/30.
//

import Foundation

protocol InfoScreenPresenterProtocol {}

final class InfoScreenPresenter {
    
    var interactor: InfoScreenInteractorProtocol?
    var wireframe: InfoScreenWireframeProtocol?
}

extension InfoScreenPresenter: InfoScreenPresenterProtocol {}
