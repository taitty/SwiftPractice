//
//  SearchDetailScreenViewModel.swift
//  myAppStore
//
//  Created by 김희수 on 2022/03/19.
//

import UIKit
import ReactiveSwift

private let searchDetailScreenLayoutData = [
    "titleCell",
    "labelCollectionCell",
    "historyCell",
    "imageCollectionCell",
    "descriptionCell"
]

class SearchDetailScreenViewModel {
    
    var viewData = MutableProperty<SearchModel?>(nil)
    
    func onViewDidLoad(item: SearchModel?) {
        guard let item = item else {
            Log.Debug(.UI, "item is empty")
            return
        }
        updateData(item: item)
    }
    
    func getViewLayout() -> [String] {
        return searchDetailScreenLayoutData
    }
    
    private func updateData(item: SearchModel) {
        viewData.value = item
    }
    
}
