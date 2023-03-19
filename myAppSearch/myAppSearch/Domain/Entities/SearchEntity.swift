//
//  SearchEntity.swift
//  myAppSearch
//
//  Created by 김희수 on 2023/03/20.
//

import Foundation

struct AppDescription: Codable {
    let type: String
    let text_1st: String
    let text_2nd: String
    let text_3rd: String
    let rating: Double
}

struct AppInfo: Codable {
    let appIcon: String
    let appTitle: String
    let summary: String
    let rating: Double
    let info: [AppDescription]
    let version: String
    let updateDate: String
    let history: String
    let previewImage: [String]
    let guide: String
    let companyName: String
    let vote: Int
}
