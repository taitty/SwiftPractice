//
//  SearchEntity.swift
//  myAppStore
//
//  Created by 김희수 on 2022/03/20.
//

import Foundation

class AppInfo {
    var text_1st: String?
    var text_2nd: String?
    var text_3rd: String?
}

class SearchModel {
    var type: String?
    
    var appIcon: String?
    var appTitle: String?
    var summary: String?
    var rating: String?
    var preview: [String]?
    
    var info: [AppInfo]?
    
    var version: String?
    var updateDate: String?
    var history: String?
    
    var previewImage: [String]?
    
    var guide: String?
    var companyName: String?
}
