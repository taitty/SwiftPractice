//
//  DetailScreenPresenter.swift
//  myPhotoBrowser
//
//  Created by 김희수 on 2022/03/30.
//

import Foundation

protocol DetailScreenPresenterProtocol {}

final class DetailScreenPresenter {
    
    var interactor: DetailScreenInteractorProtocol?
    var wireframe: DetailScreenWireframeProtocol?
}

extension DetailScreenPresenter: DetailScreenPresenterProtocol {}
