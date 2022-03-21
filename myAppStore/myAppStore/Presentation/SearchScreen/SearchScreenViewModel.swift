//
//  SearchScreenViewModel.swift
//  myAppStore
//
//  Created by 김희수 on 2022/03/19.
//

import UIKit
import ReactiveSwift

class SearchScreenViewData {
    var appIcon: String?
    var appTitle: String?
    var summary: String?
    var rating: Double?
    var preview: [String]?
    
    init(appIcon: String?, appTitle: String?, summary: String?, rating: Double?, preview: [String]?) {
        self.appIcon = appIcon
        self.appTitle = appTitle
        self.summary = summary
        self.rating = rating
        self.preview = preview
    }
}

class SearchScreenViewModel {
    
    var viewData = MutableProperty<[SearchScreenViewData]>([])
    
    private var disposables = CompositeDisposable()
    private var selectedItem: String?
    
    deinit {
        disposables.dispose()
        Log.Debug(.UI, "")
    }
    
    func onViewDidLoad() {
        Log.Debug(.UI, "")
    }
    
    func setSelectedItem(index: Int) {
        Log.Debug(.UI, "")
        selectedItem = viewData.value[index].appTitle
    }
    
    func getSelectedItem() -> String? {
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
                Log.Debug(.UI, "")
                self.convertData(data: data)
            case .failure(let error):
                Log.Debug(.UI, error.message)
            }
        }
    }
    
    private func convertData(data: [SearchModel]) {
        viewData.value = data.compactMap {
            SearchScreenViewData(appIcon: $0.appIcon, appTitle: $0.appTitle, summary: $0.summary, rating: $0.rating, preview: $0.preview)
        }
    }
    
}
