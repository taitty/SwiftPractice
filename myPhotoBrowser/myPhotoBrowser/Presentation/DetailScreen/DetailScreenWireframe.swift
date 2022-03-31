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
    
    private var dataSource: UnsplashDataSourceProtocol
    private var view: UIViewController?
    private var currentIdx: Int
    private var data: [PhotoInfo]
    
    init(dataSource: UnsplashDataSourceProtocol, data: [PhotoInfo], currentIdx: Int) {
        self.dataSource = dataSource
        self.currentIdx = currentIdx
        self.data = data
    }
    
    func setup() -> UIViewController {
        let storyboard = UIStoryboard(name: "DetailScreen", bundle: Bundle.main)
        let view = storyboard.instantiateViewController(withIdentifier: "DetailScreen") as? DetailScreenViewController
        let presenter = DetailScreenPresenter()
        let interactor = DetailScreenInteractor()
        
        self.view = view
        view?.presenter = presenter
        view?.viewData = self.data
        view?.currentIdx = self.currentIdx
        presenter.interactor = interactor
        presenter.wireframe = self
        interactor.dataSource = self.dataSource
        interactor.currentIdx = self.currentIdx
        
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
