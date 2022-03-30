//
//  UnsplashDataSource.swift
//  myPhotoBrowser
//
//  Created by 김희수 on 2022/03/30.
//

import Foundation

struct UnsplashExif: Decodable {
    var maker: String?
    var focalLength: String?
    var model: String?
    var iso: Int?
    var shutterSpeed: String?
    var aperture: String?
    
    enum CodingKeys: String, CodingKey {
        case maker = "make"
        case focalLength = "focal_length"
        case model
        case iso
        case shutterSpeed = "exposure_time"
        case aperture
    }
}

struct UnsplashPosition: Decodable {
    var latitude: Float?
    var longitude: Float?
    
    enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
    }
}

struct UnsplashLocation: Decodable {
    var location: String?
    var coordinate: UnsplashPosition?
    
    enum CodingKeys: String, CodingKey {
        case location = "name"
        case coordinate = "position"
    }
}

struct UnsplashUrls: Decodable {
    var small: String?
    var regular: String?
    
    enum CodingKeys: String, CodingKey {
        case small
        case regular
    }
}

struct UnsplashUser: Decodable {
    var name: String?
    
    enum CodingKeys: String, CodingKey {
        case name
    }
}

struct UnsplashPhotoDetail: Decodable {
    var id: String?
    var artist: UnsplashUser?
    var imgUrl: UnsplashUrls?
    var location: UnsplashLocation?
    var exif: UnsplashExif?
    var description: String?
    var dimension_width: Int?
    var dimension_height: Int?
    var published: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case artist = "user"
        case imgUrl = "urls"
        case location
        case exif
        case description
        case dimension_width = "width"
        case dimension_height = "height"
        case published = "created_at"
    }
}

struct UnsplashPhotoListItem: Decodable {
    var id: String?
    var artist: UnsplashUser?
    var imgUrl: UnsplashUrls?
    
    enum CodingKeys: String, CodingKey {
        case id
        case artist = "user"
        case imgUrl = "urls"
    }
}

struct UnsplashSearchList: Decodable {
    var results: [UnsplashPhotoListItem]?
    
    enum CodingKeys: String, CodingKey {
        case results
    }
}

final class UnsplashDataSource {
    
    private func convertHomeData(data: [UnsplashPhotoListItem]) -> [PhotoInfo] {
        data.compactMap {
            PhotoInfo(id: $0.id, artist: $0.artist?.name, smlImgUrl: $0.imgUrl?.small)
        }
    }
}

extension UnsplashDataSource: UnsplashDataSourceProtocol {
    
    func getPhotoList() -> [PhotoInfo] {
        return []
    }
    
    func getPhotoDetail() -> PhotoDetail {
        return PhotoDetail()
    }
    
    func getSearchResult() -> [PhotoInfo] {
        return []
    }
    
}
