//
//  TableViewData.swift
//  myTableViewFactory
//
//  Created by 김희수 on 2021/12/22.
//

import Foundation

class TableViewDataModel: Codable {
    var title: String
    var type: String
    var item: Array<TableViewDataModel>
}

class TableViewDataManager {
    
    func getTableViewData() -> [TableViewDataModel] {
        let decoder = JSONDecoder()
        let data = sampleData.data(using: .utf8)
        guard let data = data else {
            print("failed to load viewData")
            return []
        }
        
        if let viewData = try? decoder.decode([TableViewDataModel].self, from: data) {
            return viewData
        } else {
            print("failed to load viewData")
            return []
        }
    }
    
}

let sampleData = """
    [
        {
            "title" : "1",
            "type" : "buttonType",
            "item" : []
        },
        {
            "title" : "2",
            "type" : "labelType",
            "item" : []

        },
        {
            "title" : "3",
            "type" : "subTableType",
            "item" : [
                {
                    "title" : "3-1",
                    "type" : "buttonType",
                    "item" : []
                },
                {
                    "title" : "3-2",
                    "type" : "labelType",
                    "item" : []
                },
                {
                    "title" : "3-3",
                    "type" : "subTableType",
                    "item" : [
                        {
                            "title" : "3-3-1",
                            "type" : "buttonType",
                            "item" : []
                        },
                        {
                            "title" : "3-3-2",
                            "type" : "labelType",
                            "item" : []
                        }
                    ]
                }
            ]
        },
        {
            "title" : "4",
            "type" : "subTableType",
            "item" : [
                {
                    "title" : "4-1",
                    "type" : "buttonType",
                    "item" : []
                },
                {
                    "title" : "4-2",
                    "type" : "buttonType",
                    "item" : []
                }
            ]
        },
        {
            "title" : "5",
            "type" : "buttonType",
            "item" : []
        }
    ]
"""
