//
//  MovieGuideEntity.swift
//  myMovieGuide
//
//  Created by 김희수 on 2022/02/09.
//

import Foundation

enum MovieGuideCategory: String, CaseIterable {
    case popular
    case nowPlaying
    case upComing
}

class MovieGuideContentData {
    var id: Int?
    var title: String?
    var description: String?
    var actor: String?
    var voting: Int?
    var imgPath: String?
    
    init(id: Int? = nil, title: String? = nil, description: String? = nil, actor: String? = nil, voting: Int? = nil, imgPath: String? = nil) {
        self.id = id
        self.title = title
        self.description = description
        self.actor = actor
        self.voting = voting
        self.imgPath = imgPath
    }
}

class MovieGuideContentList {
    var category: MovieGuideCategory
    var data: [MovieGuideContentData]
    
    init(category: MovieGuideCategory, data: [MovieGuideContentData]) {
        self.category = category
        self.data = data
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
