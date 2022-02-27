//
//  TmdbDataSourceProtocol.swift
//  myMovieGuide
//
//  Created by 김희수 on 2022/02/07.
//

import Foundation
import ReactiveSwift

enum TmdbDataCategory: Int {
    case popular
    case nowplaying
    case upcoming
    case detail
    
    var toString: String {
        switch self {
        case .popular:
            return "popular"
        case .nowplaying:
            return "nowplaying"
        case .upcoming:
            return "upcoming"
        case .detail:
            return "detail"
        }
    }
}

struct TmdbDataContent {
    var id: Int?
    var title: String?
    var imagePath: String?
    var voting: String?
    var releaseDate: String?
    var genres: [String]?
    var description: String?
    var runtime: Int?
    var director: String?
    var actors: [String]?
    
    init(id: Int? = nil, title: String? = nil, imgPath: String? = nil, voting: String? = nil, releaseDate: String? = nil, genres: [String]? = nil, description: String? = nil, runtime: Int? = nil, director: String? = nil, actors: [String]? = nil) {
        self.id = id
        self.title = title
        self.imagePath = imgPath
        self.voting = voting
        self.releaseDate = releaseDate
        self.genres = genres
        self.description = description
        self.runtime = runtime
        self.director = director
        self.actors = actors
    }
}

struct TmdbData {
    var type: TmdbDataCategory
    var data: [TmdbDataContent]
}

protocol TmdbDataSourceProtocol {
    func getContentList(type: TmdbDataCategory) -> SignalProducer<TmdbData, TraceError>
    func getContentDetail(id: String) -> SignalProducer<TmdbDataContent, TraceError>
}
