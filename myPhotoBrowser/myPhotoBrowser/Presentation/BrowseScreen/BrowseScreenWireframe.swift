//
//  BrowseScreenWireframe.swift
//  myPhotoBrowser
//
//  Created by 김희수 on 2022/03/30.
//

import Foundation
import UIKit

protocol BrowseScreenWireframeProtocol {
    func routeToDetailScreen(content: String?)
}

final class BrowseScreenWireframe {
    
    private var dataSource: UnsplashDataSourceProtocol?
    private var view: UIViewController?
    
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
    
    func routeToDetailScreen(content: String?) {
        guard let view = self.view, let dataSource = self.dataSource else {
            Log.Debug(.UI, "BrowseScreen is not created...")
            return
        }
        guard let content = content else {
            Log.Debug(.UI, "content is empty...")
            return
        }
        let wireframe = DetailScreenWireframe(dataSource: dataSource, content: content)
        wireframe.setup()
        wireframe.push(from: view)
    }
}
