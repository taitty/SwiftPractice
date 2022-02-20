//
//  TmdbDataSourceProtocol.swift
//  myMovieGuide
//
//  Created by 김희수 on 2022/02/07.
//

import Foundation
import ReactiveSwift

enum TmdbDataCategory: String {
    case popular
    case nowPlaying
    case upComing
}

enum TmdbDataType {
    case contentList
    case contentDetail
}

struct TmdbDataContent {
    var id: Int?
    var title: String?
    var imagePath: String?
    var voting: Int?
    
    init(id: Int? = nil, title: String? = nil, imgPath: String? = nil, voting: Int? = nil) {
        self.id = id
        self.title = title
        self.imagePath = imgPath
        self.voting = voting
    }
}

struct TmdbData {
    var type: TmdbDataCategory
    var data: [TmdbDataContent]
}

protocol TmdbDataSourceProtocol {
    func getContentList(type: TmdbDataCategory) -> SignalProducer<TmdbData, TraceError>
}
