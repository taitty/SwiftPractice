//
//  TableViewCellPresenter.swift
//  socialPlatform
//
//  Created by 김희수 on 2022/01/06.
//

import Foundation

protocol TableViewCellPresenterProtocol {
    func onViewDidLoad()
}

final class TableViewCellPresenter {
    
    var view: TableViewCellViewProtocol?
    var interactor: TableViewCellInteractorProtocol?
    var wireframe: TableViewCellWireframeProtocol?

}

extension TableViewCellPresenter: TableViewCellPresenterProtocol {
    
    func onViewDidLoad() {
        let data = interactor?.requestViewData()
        view?.updateTableViewData(data: data)
    }
}
