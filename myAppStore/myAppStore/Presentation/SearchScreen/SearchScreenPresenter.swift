//
//  SearchScreenPresenter.swift
//  myAppStore
//
//  Created by 김희수 on 2022/03/19.
//

import UIKit

protocol SearchScreenPresenterProtocol {
    func onViewDidLoad()
}

class SearchScreenPresenter {
    
    var interactor: SearchScreenInteractorProtocol?
    var router: SearchScreenRouterProtocol?
    
}

extension SearchScreenPresenter: SearchScreenPresenterProtocol {
    
    func onViewDidLoad() {
        
    }
}
