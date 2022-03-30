//
//  DetailScreenWireframe.swift
//  myPhotoBrowser
//
//  Created by 김희수 on 2022/03/30.
//

import Foundation
import UIKit

protocol DetailScreenWireframeProtocol {

}

final class DetailScreenWireframe {
    
    private var dataSource: UnsplashDataSourceProtocol?
    private var view: UIViewController?
    private var contentId: String?
    
    init(dataSource: UnsplashDataSourceProtocol?, content: String?) {
        self.dataSource = dataSource
        self.contentId = content
    }
    
    func setup() -> UIViewController {
        let storyboard = UIStoryboard(name: "DetailScreen", bundle: Bundle.main)
        let view = storyboard.instantiateViewController(withIdentifier: "DetailScreen") as? DetailScreenViewController
        let presenter = DetailScreenPresenter()
        let interactor = DetailScreenInteractor()
        
        self.view = view
        view?.presenter = presenter
        presenter.interactor = interactor
        presenter.wireframe = self
        interactor.dataSource = self.dataSource
        interactor.contentId = self.contentId
        
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

extension DetailScreenWireframe: DetailScreenWireframeProtocol {}
