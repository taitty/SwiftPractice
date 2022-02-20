//
//  HomeScreenWireframe.swift
//  myMovieGuide
//
//  Created 김희수 on 2022/01/26.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol HomeScreenWireframeProtocol: AnyObject {
    func routeToDetailScreen(from: UIViewController)
}

final class HomeScreenWireframe {

    init() {}

    func setup() -> UIViewController{
        let storyBoardName = "HomeScreen"
        let storyBoard = UIStoryboard(name: storyBoardName, bundle: Bundle.main)
        let view = storyBoard.instantiateViewController(withIdentifier: "HomeScreenViewController") as! HomeScreenViewController
        let interactor = HomeScreenInteractor()
        let presenter = HomeScreenPresenter()

        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireframe = self
        interactor.presenter = presenter

        return view
    }
}

extension HomeScreenWireframe:HomeScreenWireframeProtocol {
    
    func routeToDetailScreen(from: UIViewController) {
        guard let next = try? DIContainer.resolve(DetailScreenWireframe.self) else {
            Log.Debug(.UI, "failed to resolve DetailScreenWireframe")
            return
        }
        let nextVC = next.setup()
        nextVC.modalPresentationStyle = .fullScreen
        DispatchQueue.main.async {
            from.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    
}
