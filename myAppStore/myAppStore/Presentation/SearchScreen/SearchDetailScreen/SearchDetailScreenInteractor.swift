//
//  SearchDetailScreenInteractor.swift
//  myAppStore
//
//  Created by 김희수 on 2022/03/23.
//

import Foundation
import ReactiveSwift

protocol SearchDetailScreenInteractorProtocol {
    func getCellData() -> SearchModel?
    var viewData: MutableProperty<SearchModel?> { get }
}

final class SearchDetailScreenInteractor {
    
    var viewData = MutableProperty<SearchModel?>(nil)
    
    
}

extension SearchDetailScreenInteractor: SearchDetailScreenInteractorProtocol {
    
    func getCellData() -> SearchModel? {
        return viewData.value
    }
    
}
