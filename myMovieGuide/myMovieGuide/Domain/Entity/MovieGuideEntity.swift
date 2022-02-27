//
//  MovieGuideEntity.swift
//  myMovieGuide
//
//  Created by 김희수 on 2022/02/09.
//

import Foundation

enum MovieGuideCategory: Int, CaseIterable {
    case popular
    case nowplaying
    case upcoming
    
    var toString: String {
        switch self {
        case .popular:
            return "popular"
        case .nowplaying:
            return "nowplaying"
        case .upcoming:
            return "upcoming"
        }
    }
    
    var titleString: String {
        switch self {
        case .popular:
            return "Popular"
        case .nowplaying:
            return "Now Playing"
        case .upcoming:
            return "Up Coming"
        }
    }
}

class MovieGuideContentData {
    var id: Int?
    var title: String?
    var description: String?
    var director: String?
    var actor: String?
    var voting: String?
    var imgPath: String?
    var etc: [String]?
    var releaseDate: String?
    var genres: [String]?
    var runtime: Int?
    
    init(id: Int? = nil, title: String? = nil, description: String? = nil, director: String? = nil, actor: String? = nil, voting: String? = nil, imgPath: String? = nil, releaseDate: String? = nil, genres: [String]? = nil, runtime: Int? = nil) {
        self.id = id
        self.title = title
        self.description = description
        self.director = director
        self.actor = actor
        self.voting = voting
        self.imgPath = imgPath
        self.releaseDate = releaseDate
        self.genres = genres
        self.runtime = runtime
        
        var etc: [String] = []
        if let date = releaseDate {
            etc.append(date)
        }
        if let runtime = runtime {
            etc.append(String(describing: runtime).appending("min."))
        }
        if let voting = voting {
            etc.append(voting)
        }
        self.etc = etc
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
