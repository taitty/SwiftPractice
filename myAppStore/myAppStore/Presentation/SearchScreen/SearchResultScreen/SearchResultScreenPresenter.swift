//
//  SearchResultScreenPresenter.swift
//  myAppStore
//
//  Created by 김희수 on 2022/03/19.
//

import UIKit
import ReactiveSwift

protocol SearchResultScreenPresenterProtocol {
    func onViewDidLoad()
    func itemSelected(index: Int)
    func getNumOfData() -> Int?
    func getCellData(index: Int) -> SearchModel?
    func requestSearch(keyword: String)
}

final class SearchResultScreenPresenter {
    
    weak var view: SearchResultScreenViewControllerProtocol?
    var interactor: SearchResultScreenInteractorProtocol?
    var wireframe: SearchResultScreenWireframeProtocol?
    
    private var disposables = CompositeDisposable()
    
    deinit {
        disposables.dispose()
        Log.Debug(.UI, "")
    }
    
    private func addObserver() {
        disposables += interactor?.viewData.signal.observeValues { value in
            self.view?.updateScreen(showMessage: !value.isEmpty)
        }
    }
}

extension SearchResultScreenPresenter: SearchResultScreenPresenterProtocol {
    
    func onViewDidLoad() {
        Log.Debug(.UI, "")
        addObserver()
    }
    
    func itemSelected(index: Int) {
        Log.Debug(.UI, "")
        let data = interactor?.getSelectedData(index: index)
        wireframe?.routeToDetailScreen(data: data)
    }
    
    func getNumOfData() -> Int? {
        return interactor?.getNumOfData()
    }

    func getCellData(index: Int) -> SearchModel? {
        return interactor?.getSelectedData(index: index)
    }
    
    func requestSearch(keyword: String) {
        interactor?.requestSearch(keyword: keyword)
    }
    
}
