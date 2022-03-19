//
//  SearchDetailScreenPresenter.swift
//  myAppStore
//
//  Created by 김희수 on 2022/03/19.
//

import UIKit

protocol SearchDetailScreenPresenterProtocol {
    func onViewDidLoad()
}

class SearchDetailScreenPresenter {
    
    var interactor: SearchDetailScreenInteractorProtocol?
    var router: SearchDetailScreenRouterProtocol?
    
}

extension SearchDetailScreenPresenter: SearchDetailScreenPresenterProtocol {
    
    func onViewDidLoad() {
        
    }
}
