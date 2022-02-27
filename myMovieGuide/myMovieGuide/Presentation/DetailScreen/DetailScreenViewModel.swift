//
//  DetailScreenViewModel.swift
//  myMovieGuide
//
//  Created by 김희수 on 2022/02/22.
//

import Foundation

class DetailScreenContent {
    var id: Int?
    var title: String?
    var image: String?
    var director: String?
    var player: String?
    var description: String?
    var genres: String?
    var etc: String?
    
    init(id: Int? = nil, title: String? = nil, image: String? = nil, director: String? = nil, player: String? = nil, description: String? = nil, genres: String? = nil, etc: String? = nil) {
        self.id = id
        self.title = title
        self.image = image
        self.director = director
        self.player = player
        self.description = description
        self.genres = genres
        self.etc = etc
    }
}
