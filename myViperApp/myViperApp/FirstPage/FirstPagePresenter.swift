//
//  FirstPagePresenter.swift
//  myViperApp
//
//  Created by 김희수 on 2021/11/08.
//

import Foundation

protocol FirstPagePresenterProtocol: AnyObject {
    var view: FirstPageViewControllerProtocol? { get set }
    var interactor: FirstPageInteractorProtocol? { get set }
    var router: FirstPageRouterProtocol? { get set }
}

class FirstPagePresenter: FirstPagePresenterProtocol {
 
    weak var view: FirstPageViewControllerProtocol?
    var interactor: FirstPageInteractorProtocol?
    var router: FirstPageRouterProtocol?
}
