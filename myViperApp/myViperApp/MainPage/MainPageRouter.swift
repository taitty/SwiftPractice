//
//  MainPageRouter.swift
//  myViperApp
//
//  Created by 김희수 on 2021/11/05.
//

import Foundation
import UIKit

protocol MainPageRouterProtocol {
    static func createMainPage(from view: MainPageViewController)
    func changePage(from: UIViewController, to: PageType) -> ErrorType
}

class MainPageRouter: MainPageRouterProtocol {

    static func createMainPage(from view: MainPageViewController) {
        let presenter = MainPagePresenter()
        
        view.presenter = presenter
        
        presenter.interactor = MainPageInteractor()
        presenter.router = MainPageRouter()
        presenter.view = view
        
        presenter.interactor?.presenter = presenter
    }
    
    func changePage(from: UIViewController, to: PageType) -> ErrorType {
        
        switch to {
        case .firstpage:
            let vc = UIStoryboard(name: "FirstPage", bundle: Bundle.main).instantiateViewController(withIdentifier: "FirstPage")
            from.navigationController?.pushViewController(vc, animated: true)
        default:
            return .error_wrong_page
        }
        return .error_none
    }
}
