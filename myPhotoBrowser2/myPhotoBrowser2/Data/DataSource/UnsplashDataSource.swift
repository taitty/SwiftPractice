//
//  UnsplashDataSource.swift
//  myPhotoBrowser2
//
//  Created by 김희수 on 2022/05/01.
//

import Combine
import UIKit

enum UnsplashApi {
    case photoList
    case photoDetail
    case search
    
    var url: String {
        switch self {
        case .photoList:
            return "/photos"
        case .photoDetail:
            return "/photos"
        case .search:
            return "/search/photos"
        }
    }
}

enum BaseUrl {
    case key
    case endPoint
    
    var url: String {
        switch self {
        case .key:
            return "BqjaIa_WxbA-Tblyibu_hVXXaj4BN2nBMkyVWD6Wsj8"
        case .endPoint:
            return "https://api.unsplash.com"
        }
    }
}

struct UnsplashExif: Decodable {
    let maker: String
    let focalLength: String
    let model: String
    let iso: Int
    let shutterSpeed: String
    let aperture: String
    
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
    let latitude: Double?
    let longitude: Double?
    
    enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
    }
}

struct UnsplashLocation: Decodable {
    let location: String?
    let coordinate: UnsplashPosition
    
    enum CodingKeys: String, CodingKey {
        case location = "name"
        case coordinate = "position"
    }
}

struct UnsplashUrls: Decodable {
    let small: String
    let regular: String
    
    enum CodingKeys: String, CodingKey {
        case small
        case regular
    }
}

struct UnsplashUser: Decodable {
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name
    }
}

struct UnsplashPhotoDetail: Decodable {
    let id: String
    let artist: UnsplashUser
    let imgUrl: UnsplashUrls
    let location: UnsplashLocation
    let exif: UnsplashExif
    let description: String?
    let dimension_width: Int
    let dimension_height: Int
    let published: String
    
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
    let id: String
    let artist: UnsplashUser
    let imgUrl: UnsplashUrls
    let width: Int
    let height: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case artist = "user"
        case imgUrl = "urls"
        case width
        case height
    }
}

struct UnsplashSearchList: Decodable {
    let results: [UnsplashPhotoListItem]
    
    enum CodingKeys: String, CodingKey {
        case results
    }
}

struct UnsplashDataSource: UnsplashDataSourceProtocol {
    
    func getPhotoList(pageNumber: Int) -> AnyPublisher<[PhotoInfo], TraceError> {
        let baseUrl = BaseUrl.endPoint.url.appending(UnsplashApi.photoList.url)
        var urlComponents = URLComponents(string: baseUrl)
        urlComponents?.queryItems = [
            URLQueryItem(name: "client_id", value: BaseUrl.key.url),
            URLQueryItem(name: "page", value: "\(pageNumber)"),
            URLQueryItem(name: "per_page", value: "30")
        ]
        
        guard let url = urlComponents?.url else {
            return Fail<[PhotoInfo], TraceError>(error: TraceError(message: "failed to create url request...")).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(
                type: [UnsplashPhotoListItem].self,
                decoder: JSONDecoder()
            )
            .mapError {
                TraceError(message: "\($0)")
            }
            .map {
                $0.compactMap {
                    PhotoInfo(id: $0.id, artist: $0.artist.name, smlImgUrl: $0.imgUrl.small, width: $0.width, height: $0.height)
                }
            }
            .eraseToAnyPublisher()
    }
    
    func getPhotoDetail(id: String) -> AnyPublisher<PhotoDetail, TraceError> {
        let baseUrl = BaseUrl.endPoint.url.appending(UnsplashApi.photoDetail.url)
        let requestUrl = baseUrl.appending("/").appending(id)
        var urlComponents = URLComponents(string: requestUrl)
        urlComponents?.queryItems = [
            URLQueryItem(name: "client_id", value: BaseUrl.key.url)
        ]
        
        guard let url = urlComponents?.url else {
            return Fail<PhotoDetail, TraceError>(error: TraceError(message: "failed to create url request...")).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(
                type: UnsplashPhotoDetail.self,
                decoder: JSONDecoder()
            )
            .mapError {
                TraceError(message: "\($0)")
            }
            .map {
                PhotoDetail(id: $0.id,
                            artist: $0.artist.name,
                            smlImgUrl: $0.imgUrl.small,
                            regImgUrl: $0.imgUrl.regular,
                            location: PhotoLocation(location: $0.location.location ?? "",
                                                    latitude: $0.location.coordinate.latitude ?? 0.0,
                                                    longitude: $0.location.coordinate.longitude ?? 0.0,
                                                    description: $0.description ?? ""),
                            exif: PhotoExif(maker: $0.exif.maker,
                                            focalLength: $0.exif.focalLength,
                                            model: $0.exif.model,
                                            iso: $0.exif.iso,
                                            shutterSpeed: $0.exif.shutterSpeed,
                                            dimension: String($0.dimension_width).appending(" x ").appending(String($0.dimension_height)),
                                            aperture: $0.exif.aperture,
                                            published: $0.published))
            }
            .eraseToAnyPublisher()
    }
    
    func getSearchResult(keyword: String, pageNumber: Int) -> AnyPublisher<[PhotoInfo], TraceError> {
        let baseUrl = BaseUrl.endPoint.url.appending(UnsplashApi.search.url)
        var urlComponents = URLComponents(string: baseUrl)
        urlComponents?.queryItems = [
            URLQueryItem(name: "client_id", value: BaseUrl.key.url),
            URLQueryItem(name: "page", value: "\(pageNumber)"),
            URLQueryItem(name: "per_page", value: "30"),
            URLQueryItem(name: "query", value: keyword)
        ]
        
        guard let url = urlComponents?.url else {
            return Fail<[PhotoInfo], TraceError>(error: TraceError(message: "failed to create url request...")).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(
                type: UnsplashSearchList.self,
                decoder: JSONDecoder()
            )
            .mapError {
                TraceError(message: "\($0)")
            }
            .map {
                $0.results.compactMap {
                    PhotoInfo(id: $0.id, artist: $0.artist.name, smlImgUrl: $0.imgUrl.small, width: $0.width, height: $0.height)
                }
            }
            .eraseToAnyPublisher()
    }
    
}
