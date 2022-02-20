//
//  DetailScreenWireframe.swift
//  myMovieGuide
//
//  Created 김희수 on 2022/01/28.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol DetailScreenWireframeProtocol: AnyObject {}

final class DetailScreenWireframe {

    init() {}

    func setup() -> UIViewController{
        let storyBoardName = "DetailScreen"
        let storyBoard = UIStoryboard(name: storyBoardName, bundle: Bundle.main)
        let view = storyBoard.instantiateViewController(withIdentifier: "DetailScreenViewController") as! DetailScreenViewController
        let interactor = DetailScreenInteractor()
        let presenter = DetailScreenPresenter()

        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireframe = self
        interactor.presenter = presenter

        return view
    }
}

extension DetailScreenWireframe:DetailScreenWireframeProtocol {}
