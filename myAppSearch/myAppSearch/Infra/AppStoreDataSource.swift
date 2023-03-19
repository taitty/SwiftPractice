//
//  AppStoreDataSource.swift
//  myAppSearch
//
//  Created by 김희수 on 2023/03/20.
//

import Foundation
import Combine

struct AppStoreSearchApiModel: Codable {
    var appTitle: String?
    var appIcon: String?
    var summary: String?
    var rating: Double?
    var version: String?
    var updateDate: String?
    var history: String?
    var previewImage: [String]?
    var guide: String?
    var companyName: String?
    var age: String?
    var vote: Int?
    var rank: String?
    var genre: String?
    var lang: [String]?
    
    enum CodingKeys: String, CodingKey {
        case appTitle = "trackName"
        case appIcon = "artworkUrl100"
        case summary = "sellerName"
        case rating = "averageUserRating"
        case version
        case updateDate = "currentVersionReleaseDate"
        case history = "releaseNotes"
        case previewImage = "screenshotUrls"
        case guide = "description"
        case companyName = "artistName"
        case age = "contentAdvisoryRating"
        case vote = "userRatingCount"
        case rank = "trackContentRating"
        case genre = "primaryGenreName"
        case lang = "languageCodesISO2A"
    }
}

struct AppStoreSearchApiResponse: Codable {
    var results: [AppStoreSearchApiModel]?
}

struct AppStoreDataSource: AppStoreRequirement {
    func requestSearch(keyword: String) -> AnyPublisher<AppStoreSearchApiResponse, TraceError> {
        Log.Debug(.INFRA, "keyword : \(keyword)")
        
        var urlComponents = URLComponents(string: "https://itunes.apple.com/search?")
        urlComponents?.queryItems = [
            URLQueryItem(name: "term", value: keyword),
            URLQueryItem(name: "entity", value: "software"),
            URLQueryItem(name: "country", value: "kr")
        ]
        
        guard let requestURL = urlComponents?.url else {
            let fail = Fail<AppStoreSearchApiResponse, TraceError>(error: TraceError(message: "failed to create url request..."))
            return fail.eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: requestURL)
            .map {
                Log.Debug(.INFRA, "\(String(describing: String(data: $0.data, encoding: .utf8)))")
                return $0.data }
            .decode(type: AppStoreSearchApiResponse.self, decoder: JSONDecoder())
            .mapError { TraceError(message: $0.localizedDescription) }
            .eraseToAnyPublisher()
    }
}
