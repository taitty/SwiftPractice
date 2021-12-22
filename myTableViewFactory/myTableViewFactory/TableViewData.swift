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
            "title" : "Monday",
            "type" : "buttonType",
            "item" : []
        },
        {
            "title" : "Tuesday",
            "type" : "labelType",
            "item" : []

        },
        {
            "title" : "Wednesday",
            "type" : "subTableType",
            "item" : [
                {
                    "title" : "Friday",
                    "type" : "buttonType",
                    "item" : []
                },
                {
                    "title" : "Saturday",
                    "type" : "labelType",
                    "item" : []
                },
                {
                    "title" : "Morning",
                    "type" : "buttonType",
                    "item" : []
                },
                {
                    "title" : "Evening",
                    "type" : "labelType",
                    "item" : []
                }
            ]
        },
        {
            "title" : "Thursday",
            "type" : "buttonType",
            "item" : []
        }
    ]
"""
