//
//  SearchResultScreenInteractor.swift
//  myAppStore
//
//  Created by 김희수 on 2022/03/23.
//

import Foundation
import ReactiveSwift

protocol SearchResultScreenInteractorProtocol {
    func getSelectedData(index: Int) -> SearchModel
    func getNumOfData() -> Int
    func requestSearch(keyword: String)
    var viewData: MutableProperty<[SearchModel]> { get }
}

final class SearchResultScreenInteractor {
    
    private var disposables = CompositeDisposable()
    private var dataSource: AppStoreDataSourceProtocol?
    
    var viewData = MutableProperty<[SearchModel]>([])
    
    init(dataSource: AppStoreDataSourceProtocol?) {
        self.dataSource = dataSource
    }
    
    deinit {
        disposables.dispose()
        Log.Debug(.UI, "")
    }
    
}

extension SearchResultScreenInteractor: SearchResultScreenInteractorProtocol {
    
    func getSelectedData(index: Int) -> SearchModel {
        return viewData.value[index]
    }
    
    func getNumOfData() -> Int {
        return viewData.value.count
    }
    
    func requestSearch(keyword: String) {
        Log.Debug(.UI, "start search with \(keyword)")
        guard let dataSource = self.dataSource else {
            Log.Debug(.UI, "dataSource is not installed...")
            return
        }
        
        let useCase = RequestSearchUseCase(dataSource: dataSource)
        disposables += useCase.execute(keyword: keyword).startWithResult { [weak self] result in
            guard let self = self else {
                Log.Debug(.UI, "already deinitialized...")
                return
            }
            switch result {
            case .success(let data):
                Log.Debug(.UI, "success to get data")
                self.viewData.value = data
            case .failure(let error):
                Log.Debug(.UI, error.message)
            }
        }
    }

}
