//
//  SearchDetailScreenPresenter.swift
//  myAppStore
//
//  Created by 김희수 on 2022/03/23.
//

import Foundation
import ReactiveSwift

private let searchDetailScreenLayoutData = [
    "titleCell",
    "labelCollectionCell",
    "historyCell",
    "imageCollectionCell",
    "descriptionCell"
]

protocol SearchDetailScreenPresenterProtocol {
    func onViewDidLoad()
    func getViewLayout() -> [String]?
    func getCellData() -> SearchModel?
}

final class SearchDetailScreenPresenter {
    
    weak var view: SearchDetailScreenViewControllerProtocol?
    var interactor: SearchDetailScreenInteractorProtocol?
    var wireframe: SearchDetailScreenWireframeProtocol?
    
    private var disposables = CompositeDisposable()
    
    deinit {
        disposables.dispose()
        Log.Debug(.UI, "")
    }
    
    private func addObserver() {
        disposables += interactor?.viewData.producer.skip(while: { $0 == nil }).startWithValues { _ in
            self.view?.updateScreen()
        }
    }
}

extension SearchDetailScreenPresenter: SearchDetailScreenPresenterProtocol {
    
    func onViewDidLoad() {
        Log.Debug(.UI, "")
        addObserver()
    }
    
    func getViewLayout() -> [String]? {
        return searchDetailScreenLayoutData
    }
    
    func getCellData() -> SearchModel? {
        return interactor?.getCellData()
    }
}
