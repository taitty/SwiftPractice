//
//  GenericViewData.swift
//  myGenericViewFactory
//
//  Created by 김희수 on 2021/12/30.
//

import Foundation

class ViewDataModel: Codable {
    var title: String
    var type: String
    var item: Array<ViewDataModel>
}

class ViewDataManager {
    
    func getViewData() -> [ViewDataModel] {
        let decoder = JSONDecoder()
        let data = sampleData.data(using: .utf8)
        guard let data = data else {
            print("failed to load viewData")
            return []
        }
        
        if let viewData = try? decoder.decode([ViewDataModel].self, from: data) {
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
            "title" : "1st Table - Button",
            "type" : "buttonType",
            "item" : []
        },
        {
            "title" : "1st Table - Label",
            "type" : "labelType",
            "item" : []

        },
        {
            "title" : "1st Table - Table",
            "type" : "tableType",
            "item" : [
                {
                    "title" : "2nd Table - Button",
                    "type" : "buttonType",
                    "item" : []
                },
                {
                    "title" : "2nd Table - Label",
                    "type" : "labelType",
                    "item" : []
                },
                {
                    "title" : "2nd Table - Button",
                    "type" : "buttonType",
                    "item" : []
                },
                {
                    "title" : "2nd Table - Label",
                    "type" : "labelType",
                    "item" : []
                }
            ]
        },
        {
            "title" : "1st Table - Collection",
            "type" : "collectionType",
            "item" : [
                {
                    "title" : "Collection 1",
                    "type" : "buttonType",
                    "item" : []
                },
                {
                    "title" : "Collection 2",
                    "type" : "labelType",
                    "item" : []
                },
                {
                    "title" : "Collection 3",
                    "type" : "buttonType",
                    "item" : []
                }
            ]
        },
        {
            "title" : "1st Table - Stack",
            "type" : "stackType",
            "item" : [
                {
                    "title" : "stackView",
                    "type" : "buttonType",
                    "item" : []
                },
                {
                    "title" : "stack",
                    "type" : "labelType",
                    "item" : []
                },
                {
                    "title" : "stack stack",
                    "type" : "buttonType",
                    "item" : []
                },
                {
                    "title" : "stk",
                    "type" : "labelType",
                    "item" : []
                }
            ]
        },
        {
            "title" : "1st Table - Button",
            "type" : "buttonType",
            "item" : []
        }
    ]
"""
