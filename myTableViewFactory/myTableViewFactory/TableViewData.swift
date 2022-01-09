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
                    "title" : "Dog",
                    "type" : "buttonType",
                    "item" : []
                },
                {
                    "title" : "Chichen",
                    "type" : "labelType",
                    "item" : []
                },
                {
                    "title" : "Pig",
                    "type" : "subTableType",
                    "item" : [
                        {
                            "title" : "Ant",
                            "type" : "buttonType",
                            "item" : []
                        },
                        {
                            "title" : "Bee",
                            "type" : "labelType",
                            "item" : []
                        }
                    ]
                }
            ]
        },
        {
            "title" : "Wednesday",
            "type" : "subTableType",
            "item" : [
                {
                    "title" : "Bus",
                    "type" : "buttonType",
                    "item" : []
                },
                {
                    "title" : "Taxi",
                    "type" : "buttonType",
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

let _sampleData = """
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
                    "title" : "Dog",
                    "type" : "buttonType",
                    "item" : []
                },
                {
                    "title" : "Cat",
                    "type" : "labelType",
                    "item" : []
                },
                {
                    "title" : "Pig",
                    "type" : "buttonType",
                    "item" : []
                },
                {
                    "title" : "Chichen",
                    "type" : "labelType",
                    "item" : []
                }
            ]
        },
        {
            "title" : "Wednesday",
            "type" : "subTableType",
            "item" : [
                {
                    "title" : "Bus",
                    "type" : "buttonType",
                    "item" : []
                },
                {
                    "title" : "Seden",
                    "type" : "labelType",
                    "item" : []
                },
                {
                    "title" : "HatchBag",
                    "type" : "buttonType",
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
