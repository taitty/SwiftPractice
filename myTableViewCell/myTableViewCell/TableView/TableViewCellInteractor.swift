//
//  TableViewCellInteractor.swift
//  socialPlatform
//
//  Created by 김희수 on 2022/01/06.
//

import Foundation

protocol TableViewCellInteractorProtocol {
    func requestViewData() -> [ViewDataModel]
}

final class TableViewCellInteractor {
    
    var presenter: TableViewCellPresenterProtocol?
    let dataManager = ViewDataManager()
    
}

extension TableViewCellInteractor: TableViewCellInteractorProtocol {

    func requestViewData() -> [ViewDataModel] {
        return dataManager.getViewData()
    }
}
