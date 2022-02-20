//
//  MainPresenter.swift
//  myMovieGuide
//
//  Created 김희수 on 2022/01/27.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import UIKit

protocol MainPresenterProtocol: AnyObject {
    func onViewDidLoad()
}

final class MainPresenter {
    weak var view: MainViewProtocol!
    var wireframe: MainWireframeProtocol!
    var interactor: MainInteractorProtocol!

    init() {}
}

// MARK: - PresenterProtocol

extension MainPresenter: MainPresenterProtocol {
    func onViewDidLoad() {
        interactor.configuration()
        wireframe.routeToHomeScreen(from: view as! UIViewController)
    }
}
