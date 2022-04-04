//
//  BrowseScreenWireframe.swift
//  myPhotoBrowser
//
//  Created by 김희수 on 2022/03/30.
//

import Foundation
import UIKit

protocol BrowseScreenWireframeProtocol {
    func routeToDetailScreen(data: [PhotoInfo], position: Int)
}

final class BrowseScreenWireframe {
    
    private var dataSource: UnsplashDataSourceProtocol
    private var view: BrowseScreenViewController?
    
    init(dataSource: UnsplashDataSourceProtocol) {
        self.dataSource = dataSource
    }
    
    func setup() -> UIViewController {
        let storyboard = UIStoryboard(name: "BrowseScreen", bundle: Bundle.main)
        let view = storyboard.instantiateViewController(withIdentifier: "BrowseScreen") as? BrowseScreenViewController
        let presenter = BrowseScreenPresenter()
        let interactor = BrowseScreenInteractor()
        
        self.view = view
        view?.presenter = presenter
        presenter.interactor = interactor
        presenter.wireframe = self
        interactor.dataSource = dataSource
        
        guard let view = view else {
            Log.Debug(.UI, "failed to setup BrowseScreen...")
            return UIViewController()
        }
        return view
    }

    func push(from: UIViewController) {
        guard let view = self.view else {
            Log.Debug(.UI, "BrowseScreen is not created...")
            return
        }
        view.modalPresentationStyle = .fullScreen
        from.present(view, animated: true, completion: nil)
    }
}

extension BrowseScreenWireframe: BrowseScreenWireframeProtocol {
    
    func routeToDetailScreen(data: [PhotoInfo], position: Int) {
        guard let view = self.view else {
            Log.Debug(.UI, "BrowseScreen is not created...")
            return
        }

        let wireframe = DetailScreenWireframe(dataSource: dataSource, dataDelegate: view, data: data, position: position)
        _ = wireframe.setup()
        wireframe.push(from: view)
    }
}
