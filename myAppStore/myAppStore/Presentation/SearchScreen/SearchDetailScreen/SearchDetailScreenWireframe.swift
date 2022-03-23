//
//  SearchDetailScreenWireframe.swift
//  myAppStore
//
//  Created by 김희수 on 2022/03/23.
//

import UIKit

protocol SearchDetailScreenWireframeProtocol {
    
}

final class SearchDetailScreenWireframe {

    private var view: UIViewController?
    
    func create(data: SearchModel?) {
        let presenter = SearchDetailScreenPresenter()
        let interactor = SearchDetailScreenInteractor()
        let storyboard = UIStoryboard(name: "SearchDetailScreen", bundle: Bundle.main)
        let view = storyboard.instantiateViewController(withIdentifier: "SearchDetailScreen") as? SearchDetailScreenViewController
        
        self.view = view
        view?.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireframe = self
        interactor.viewData.value = data
    }
    
    func push(from: UIViewController) {
        guard let view = view else {
            Log.Debug(.UI, "SearchDetailScreen is not created...")
            return
        }
        from.navigationController?.pushViewController(view, animated: true)
    }
}

extension SearchDetailScreenWireframe: SearchDetailScreenWireframeProtocol {
    
}
