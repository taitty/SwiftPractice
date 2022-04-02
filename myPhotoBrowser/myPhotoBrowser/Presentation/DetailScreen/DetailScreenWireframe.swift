//
//  DetailScreenWireframe.swift
//  myPhotoBrowser
//
//  Created by 김희수 on 2022/03/30.
//

import Foundation
import UIKit

protocol DetailScreenWireframeProtocol {
    func routeToInfoScreen(id: String)
    func routeToBrowseScreen()
}

final class DetailScreenWireframe {
    
    private var dataSource: UnsplashDataSourceProtocol
    private var view: DetailScreenViewController?
    private var delegate: DetailScreenDataDelegate?
    
    init(dataSource: UnsplashDataSourceProtocol, dataDelegate: DetailScreenDataDelegate) {
        self.dataSource = dataSource
        self.delegate = dataDelegate
    }
    
    func setup() -> UIViewController {
        let storyboard = UIStoryboard(name: "DetailScreen", bundle: Bundle.main)
        let view = storyboard.instantiateViewController(withIdentifier: "DetailScreen") as? DetailScreenViewController
        let presenter = DetailScreenPresenter()
        let interactor = DetailScreenInteractor()
        
        self.view = view
        view?.presenter = presenter
        view?.dataDelegate = self.delegate
        presenter.interactor = interactor
        presenter.wireframe = self
        interactor.dataSource = self.dataSource
        
        guard let view = view else {
            Log.Debug(.UI, "failed to setup DetailScreen...")
            return UIViewController()
        }
        return view
    }

    func push(from: UIViewController) {
        guard let view = self.view else {
            Log.Debug(.UI, "DetailScreen is not created...")
            return
        }
        view.modalPresentationStyle = .fullScreen
        from.present(view, animated: true, completion: nil)
    }
}

extension DetailScreenWireframe: DetailScreenWireframeProtocol {
    
    func routeToInfoScreen(id: String) {
        guard let view = self.view else {
            Log.Debug(.UI, "DetailScreen is not created...")
            return
        }
        
        let wireframe = InfoScreenWireframe(dataSource: dataSource, id: id)
        _ = wireframe.setup()
        wireframe.push(from: view)
    }
    
    func routeToBrowseScreen() {
        self.view?.dismiss(animated: true, completion: nil)
    }
}
