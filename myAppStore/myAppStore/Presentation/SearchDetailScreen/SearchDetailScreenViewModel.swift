//
//  SearchDetailScreenViewModel.swift
//  myAppStore
//
//  Created by 김희수 on 2022/03/19.
//

import UIKit

private let searchDetailScreenLayoutData = [
    "titleCell",
    "labelCollectionCell",
    "historyCell",
    "imageCollectionCell",
    "descriptionCell"
]

class searchDetailScreenDataModel: Codable {
    var title: String
    var type: String
}

class SearchDetailScreenViewModel {
    
    func onViewDidLoad() {
        Log.Debug(.UI, "")
    }
    
    func getViewLayout() -> [String] {
        return searchDetailScreenLayoutData
    }
    
    func getViewData() -> [searchDetailScreenDataModel] {
        let decoder = JSONDecoder()
        let data = searchDetailScreenData.data(using: .utf8)
        guard let data = data else {
            print("failed to load viewData")
            return []
        }
        
        if let data = try? decoder.decode([searchDetailScreenDataModel].self, from: data) {
            return data
        } else {
            print("failed to load viewData")
            return []
        }
    }
    
}

let searchDetailScreenData = """
"""
