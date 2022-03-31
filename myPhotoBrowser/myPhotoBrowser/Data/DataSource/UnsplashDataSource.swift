//
//  UnsplashDataSource.swift
//  myPhotoBrowser
//
//  Created by 김희수 on 2022/03/30.
//

import Foundation
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
    var width: Int?
    var height: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case artist = "user"
        case imgUrl = "urls"
        case width
        case height
    }
}

struct UnsplashSearchList: Decodable {
    var results: [UnsplashPhotoListItem]?
    
    enum CodingKeys: String, CodingKey {
        case results
    }
}

final class UnsplashDataSource {
    
    var cancellable = Set<AnyCancellable>()
    
    private func request<T: Decodable>(_ request: URLRequest) -> AnyPublisher<T, TraceError> {
        return URLSession.shared.dataTaskPublisher(for: request)
            .print()
            .map(\.data)
            .decode(
                type: T.self,
                decoder: JSONDecoder()
            )
            .mapError { error in
                TraceError(message: error.localizedDescription)
            }
            .eraseToAnyPublisher()
    }
}

extension UnsplashDataSource: UnsplashDataSourceProtocol {
    
    func getPhotoList() -> AnyPublisher<[PhotoInfo], TraceError> {
        let baseUrl = BaseUrl.endPoint.url.appending(UnsplashApi.photoList.url)
        var urlComponents = URLComponents(string: baseUrl)
        urlComponents?.queryItems = [
            URLQueryItem(name: "client_id", value: BaseUrl.key.url)
        ]
        
        guard let url = urlComponents?.url else {
            let fail = Fail<[PhotoInfo], TraceError>(error: TraceError(message: "failed to create url request..."))
            return fail.eraseToAnyPublisher()
        }

//        print("\(url.absoluteString)")
        return URLSession.shared.dataTaskPublisher(for: url)
            .mapError {
                TraceError(message: $0.localizedDescription)
            }
            .map { $0.data }
            .decode(
                type: [UnsplashPhotoListItem].self,
                decoder: JSONDecoder()
            )
            .mapError {
                TraceError(message: $0.localizedDescription)
            }
            .map {
                $0.compactMap {
                    PhotoInfo(id: $0.id, artist: $0.artist?.name, smlImgUrl: $0.imgUrl?.small, width: $0.width, height: $0.height)
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
            let fail = Fail<PhotoDetail, TraceError>(error: TraceError(message: "failed to create url request..."))
            return fail.eraseToAnyPublisher()
        }
        
//        print("\(url.absoluteString)")
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(
                type: UnsplashPhotoDetail.self,
                decoder: JSONDecoder()
            )
            .mapError { error in
                TraceError(message: error.localizedDescription)
            }
            .map {
                PhotoDetail(id: $0.id,
                            artist: $0.artist?.name,
                            smlImgUrl: $0.imgUrl?.small,
                            regImgUrl: $0.imgUrl?.regular,
                            location: PhotoLocation(location: $0.location?.location,
                                                    latitude: $0.location?.coordinate?.latitude,
                                                    longitude: $0.location?.coordinate?.longitude,
                                                    description: $0.description),
                            exif: PhotoExif(maker: $0.exif?.maker,
                                            focalLength: $0.exif?.focalLength,
                                            model: $0.exif?.model,
                                            iso: $0.exif?.iso,
                                            shutterSpeed: $0.exif?.shutterSpeed,
                                            dimension: String($0.dimension_width ?? 0).appending(" x ").appending(String($0.dimension_height ?? 0)),
                                            aperture: $0.exif?.aperture,
                                            published: $0.published))
            }
            .eraseToAnyPublisher()
    }
    
    func getSearchResult(keyword: String) -> AnyPublisher<[PhotoInfo], TraceError> {
        let baseUrl = BaseUrl.endPoint.url.appending(UnsplashApi.search.url)
        var urlComponents = URLComponents(string: baseUrl)
        urlComponents?.queryItems = [
            URLQueryItem(name: "client_id", value: BaseUrl.key.url),
            URLQueryItem(name: "query", value: keyword)
        ]
        
        guard let url = urlComponents?.url else {
            let fail = Fail<[PhotoInfo], TraceError>(error: TraceError(message: "failed to create url request..."))
            return fail.eraseToAnyPublisher()
        }
        
//        print("\(url.absoluteString)")
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(
                type: UnsplashSearchList.self,
                decoder: JSONDecoder()
            )
            .mapError { error in
                TraceError(message: error.localizedDescription)
            }
            .map {
                $0.results?.compactMap {
                    PhotoInfo(id: $0.id, artist: $0.artist?.name, smlImgUrl: $0.imgUrl?.small, width: $0.width, height: $0.height)
                } ?? []
            }
            .eraseToAnyPublisher()
    }
    
}
