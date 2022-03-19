//
//  SearchDetailScreenRouter.swift
//  myAppStore
//
//  Created by 김희수 on 2022/03/19.
//

import UIKit

protocol SearchDetailScreenRouterProtocol {
    func create() -> UIViewController
}

class SearchDetailScreenRouter {
    
    func create() -> UIViewController {
        let boardName = "SearchDetailScreen"
        let storyboard = UIStoryboard(name: boardName, bundle: Bundle.main)
        let view = storyboard.instantiateViewController(withIdentifier: "SearchDetailScreenViewController") as! SearchDetailScreenViewController
        let interactor = SearchDetailScreenInteractor()
        let presenter = SearchDetailScreenPresenter()
        
        view.presenter = presenter
        presenter.interactor = interactor
        presenter.router = self
        
        return view
    }
    
}

extension SearchDetailScreenRouter: SearchDetailScreenRouterProtocol {
    
}
