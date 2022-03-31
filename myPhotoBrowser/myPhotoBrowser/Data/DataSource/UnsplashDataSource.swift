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
    
    var cancellable = Set<AnyCancellable>()
    
    private func convertHomeData(data: [UnsplashPhotoListItem]) -> [PhotoInfo] {
        data.compactMap {
            PhotoInfo(id: $0.id, artist: $0.artist?.name, smlImgUrl: $0.imgUrl?.small)
        }
    }
    
    private func request<T: Decodable>(_ request: URLRequest) -> AnyPublisher<T, TraceError> {
        return URLSession.shared.dataTaskPublisher(for: request)
            .print()
            .map(\.data)
            .decode(
                type: T.self,
                decoder: JSONDecoder()
            )
            .mapError ({ error in
                switch error {
                case is URLError:
                    return TraceError(message: "request failed")
                case is DecodingError:
                    return TraceError(message: "invalid response")
                default:
                    return TraceError(message: "unknown")
                }
            })
            .eraseToAnyPublisher()
    }
}

extension UnsplashDataSource: UnsplashDataSourceProtocol {
    
    func getPhotoList() -> [PhotoInfo] {
        var urlComponents = URLComponents(string: BaseUrl.endPoint.url)
        let key = URLQueryItem(name: "client_id", value: BaseUrl.key.url)
        urlComponents?.queryItems?.append(key)
        
        guard let url = urlComponents?.url else {
            Log.Debug(.SERVER, "failed to create url request...")
            return []
        }
        
        let final = URLRequest(url: url)
        request(final).print().sink(receiveCompletion: { result in
            switch result {
            case .finished:
                print()
            case .failure(let error):
                print(error.message)
            }
        }, receiveValue: { (value: [UnsplashPhotoListItem]) in
            let result: [UnsplashPhotoListItem] = value
            print(result)
        }).store(in: &cancellable)
        return []
    }
    
    func getPhotoDetail() -> PhotoDetail {
        return PhotoDetail()
    }
    
    func getSearchResult() -> [PhotoInfo] {
        return []
    }
    
}
