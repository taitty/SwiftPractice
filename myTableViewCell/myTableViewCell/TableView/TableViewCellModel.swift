//
//  TableViewCellModel.swift
//  socialPlatform
//
//  Created by 김희수 on 2022/01/06.
//

import Foundation

class ViewDataModel: Codable {
    var text: String
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
            "text" : "this is description cell",
            "type" : "descriptionType",
            "item" : []
        },
        {
            "text" : "",
            "type" : "blankType",
            "item" : []

        },
        {
            "text" : "1st Section",
            "type" : "mainTitleType",
            "item" : []
        },
        {
            "text" : "Brightness",
            "type" : "sliderType",
            "item" : []

        },
        {
            "text" : "Option",
            "type" : "buttonType",
            "item" : [
                {
                    "text" : "1st",
                    "type" : "stackButtonType",
                    "item" : []
                },
                {
                    "text" : "2nd",
                    "type" : "stackButtonType",
                    "item" : []
                }
            ]
        },
        {
            "text" : "Area",
            "type" : "buttonType",
            "item" : [
                {
                    "text" : "10%",
                    "type" : "stackButtonType",
                    "item" : []
                },
                {
                    "text" : "35%",
                    "type" : "stackButtonType",
                    "item" : []
                },
                {
                    "text" : "60%",
                    "type" : "stackButtonType",
                    "item" : []
                },
                {
                    "text" : "100%",
                    "type" : "stackButtonType",
                    "item" : []
                }
            ]
        },
        {
            "text" : "",
            "type" : "blankType",
            "item" : []

        },
        {
            "text" : "2nd Section",
            "type" : "mainTitleType",
            "item" : []
        },
        {
            "text" : "This is 2nd description",
            "type" : "descriptionType",
            "item" : []
        },
        {
            "text" : "This is 3rd description",
            "type" : "descriptionType",
            "item" : []
        },
        {
            "text" : "Area",
            "type" : "buttonType",
            "item" : [
                {
                    "text" : "30%",
                    "type" : "stackButtonType",
                    "item" : []
                },
                {
                    "text" : "60%",
                    "type" : "stackButtonType",
                    "item" : []
                },
                {
                    "text" : "90%",
                    "type" : "stackButtonType",
                    "item" : []
                }
            ]
        },
        {
            "text" : "Level",
            "type" : "buttonType",
            "item" : [
                {
                    "text" : "High",
                    "type" : "stackButtonType",
                    "item" : []
                },
                {
                    "text" : "Standard",
                    "type" : "stackButtonType",
                    "item" : []
                },
                {
                    "text" : "Low",
                    "type" : "stackButtonType",
                    "item" : []
                }
            ]
        },
        {
            "text" : "",
            "type" : "blankType",
            "item" : []

        },
        {
            "text" : "3rd Section",
            "type" : "mainTitleType",
            "item" : []
        },
        {
            "text" : "This is 4th description",
            "type" : "descriptionType",
            "item" : []
        },
        {
            "text" : "",
            "type" : "buttonType",
            "item" : [
                {
                    "text" : "1st",
                    "type" : "stackButtonType",
                    "item" : []
                },
                {
                    "text" : "2nd",
                    "type" : "stackButtonType",
                    "item" : []
                }
            ]
        },
    ]
"""
