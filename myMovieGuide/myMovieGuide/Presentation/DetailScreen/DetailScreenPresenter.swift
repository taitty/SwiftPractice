//
//  DetailScreenPresenter.swift
//  myMovieGuide
//
//  Created 김희수 on 2022/01/28.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol DetailScreenPresenterProtocol: AnyObject {
    func onViewDidLoad()
}

final class DetailScreenPresenter {
    weak var view: DetailScreenViewProtocol!
    var wireframe: DetailScreenWireframeProtocol!
    var interactor: DetailScreenInteractorProtocol!

    init() {}
}

// MARK: - PresenterProtocol

extension DetailScreenPresenter: DetailScreenPresenterProtocol {
    func onViewDidLoad() {}
}
