//
//  HomeScreenViewModel.swift
//  myMovieGuide
//
//  Created by 김희수 on 2022/02/18.
//

import Foundation

class HomeScreenCategoryContent {
    var id: Int?
    var image: String?
    var title: String?
    var releaseDate: String?
    var voting: String?
    
    init(id: Int? = nil, image: String? = nil, title: String? = nil, releaseDate: String? = nil, voting: String? = nil) {
        self.id = id
        self.image = image
        self.title = title
        self.releaseDate = releaseDate
        self.voting = voting
    }
}

class HomeScreenCategory {
    var type: MovieGuideCategory?
    var title: String?
    var contents: [HomeScreenCategoryContent]?
    
    init(type: MovieGuideCategory? = nil, title: String? = nil, contents: [HomeScreenCategoryContent]? = nil) {
        self.type = type
        self.title = title
        self.contents = contents
    }
}

class HomeScreenContent {
    var data: [HomeScreenCategory]?
}
