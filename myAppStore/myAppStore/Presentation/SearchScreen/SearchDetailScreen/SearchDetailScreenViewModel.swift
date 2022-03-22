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
    
    let viewData = MutableProperty<SearchModel?>(nil)
    
    func onViewDidLoad() {
        Log.Debug(.UI, "")
    }
    
    func getViewLayout() -> [String] {
        return searchDetailScreenLayoutData
    }
    
    private func updateData(item: SearchModel) {
        viewData.value = item
    }
    
}
