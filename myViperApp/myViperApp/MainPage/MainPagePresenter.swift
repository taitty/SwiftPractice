//
//  MainPagePresenter.swift
//  myViperApp
//
//  Created by 김희수 on 2021/11/05.
//

import Foundation
import UIKit

protocol MainPagePresenterProtocol: AnyObject {
    var router: MainPageRouterProtocol? { get set }
    var interactor: MainPageInteractorProtocol? { get set }
    var view: MainPageViewControllerProtocol? { get set }
    
    func viewDidLoad()
    func requestToChangePage(from: UIViewController, to: PageType) -> ErrorType?
}

class MainPagePresenter: MainPagePresenterProtocol {
    var router: MainPageRouterProtocol?
    var interactor: MainPageInteractorProtocol?
    weak var view: MainPageViewControllerProtocol?
    
    func viewDidLoad() {
        
    }
    
    func requestToChangePage(from: UIViewController, to: PageType) -> ErrorType? {
        print("requested to change to router")
        return router?.changePage(from: from, to: to)
    }
}

