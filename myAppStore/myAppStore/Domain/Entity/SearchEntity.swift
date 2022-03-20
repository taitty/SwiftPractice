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
    var rating: Double?
    var preview: [String]?
    
    var info: [AppInfo]?
    
    var version: String?
    var updateDate: String?
    var history: String?
    
    var previewImage: [String]?
    
    var guide: String?
    var companyName: String?
    
    init(type: String? = nil,
         appIcon: String? = nil,
         appTitle: String? = nil,
         summary: String? = nil,
         rating: Double? = nil,
         preview: [String]? = nil,
         info: [AppInfo]? = nil,
         version: String? = nil,
         updateDate: String? = nil,
         history: String? = nil,
         previewImage: [String]? = nil,
         guide: String? = nil,
         companyName: String? = nil) {
        self.type = type
        self.appIcon = appIcon
        self.appTitle = appTitle
        self.summary = summary
        self.rating = rating
        self.preview = preview
        self.info = info
        self.version = version
        self.updateDate = updateDate
        self.history = history
        self.previewImage = previewImage
        self.guide = guide
        self.companyName = companyName
    }
}

class TraceError: Error {
    public let message: String
    public let code: String
    
    public init(message: String = "", code: String = "") {
        self.message = message
        self.code = code
    }
}
