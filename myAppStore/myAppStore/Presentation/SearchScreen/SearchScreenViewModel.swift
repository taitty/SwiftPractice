//
//  SearchScreenViewModel.swift
//  myAppStore
//
//  Created by 김희수 on 2022/03/19.
//

import UIKit
import ReactiveSwift

class SearchScreenViewModel {
    
    var viewData = MutableProperty<[SearchModel]>([])
    
    private var disposables = CompositeDisposable()
    private var selectedItem: SearchModel?
    
    deinit {
        disposables.dispose()
        Log.Debug(.UI, "")
    }
    
    func onViewDidLoad() {
        Log.Debug(.UI, "")
    }
    
    func setSelectedItem(index: Int) {
        Log.Debug(.UI, "")
        selectedItem = viewData.value[index]
    }
    
    func getSelectedItem() -> SearchModel? {
        return selectedItem
    }
    
    func requestSearch(keyword: String) {
        Log.Debug(.UI, "start search with \(keyword)")
        let useCase = RequestSearchUseCase()
        disposables += useCase.execute(keyword: keyword).startWithResult { [weak self] result in
            guard let self = self else {
                Log.Debug(.UI, "already deinitialized...")
                return
            }
            switch result {
            case .success(let data):
                Log.Debug(.UI, "success to get data")
                self.updateData(data: data)
            case .failure(let error):
                Log.Debug(.UI, error.message)
            }
        }
    }
    
    private func updateData(data: [SearchModel]) {
        viewData.value = data
    }
    
}
