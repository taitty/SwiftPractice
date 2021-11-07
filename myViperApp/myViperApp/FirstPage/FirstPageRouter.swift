//
//  FirstPageRouter.swift
//  myViperApp
//
//  Created by 김희수 on 2021/11/08.
//

import Foundation

protocol FirstPageRouterProtocol {
    static func createFirstPage(from view: FirstPageViewController)
    func changePage(to: PageType) -> ErrorType
}

class FirstPageRouter: FirstPageRouterProtocol {
    static func createFirstPage(from view: FirstPageViewController) {
        let presenter = FirstPagePresenter()
        
        view.presenter = presenter
        
        presenter.interactor = FirstPageInteractor()
        presenter.router = FirstPageRouter()
        presenter.view = view
        
        presenter.interactor?.presenter = presenter
    }
    
    func changePage(to: PageType) -> ErrorType {
        return .error_none
    }
}
