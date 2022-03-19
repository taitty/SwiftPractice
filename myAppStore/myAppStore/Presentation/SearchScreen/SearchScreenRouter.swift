//
//  SearchScreenRouter.swift
//  myAppStore
//
//  Created by 김희수 on 2022/03/19.
//

import UIKit

protocol SearchScreenRouterProtocol {
    func create() -> UIViewController
}

class SearchScreenRouter {
    
    func create() -> UIViewController {
        let boardName = "SearchScreen"
        let storyboard = UIStoryboard(name: boardName, bundle: Bundle.main)
        let view = storyboard.instantiateViewController(withIdentifier: "SearchScreenViewController") as! SearchScreenViewController
        let interactor = SearchScreenInteractor()
        let presenter = SearchScreenPresenter()
        
        view.presenter = presenter
        presenter.interactor = interactor
        presenter.router = self
        
        return view
    }
}

extension SearchScreenRouter: SearchScreenRouterProtocol {
    
}
