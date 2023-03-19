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
    var results: [AppStoreSearchApiModel]
}

struct AppStoreDataSource: AppStoreRequirement {
    private func convertData(from: [AppStoreSearchApiModel]) -> [AppInfo] {
        from.compactMap {
            var appDesc = [AppDescription]()
            let rating = round(($0.rating ?? 0) * 10) / 10
            appDesc.append(AppDescription(type: "rating", top: "평가", middle: String(rating), bottom: "", rating: rating))
            appDesc.append(AppDescription(type: "age", top: "연령", middle: $0.age ?? "", bottom: "세", rating: 0.0))
            appDesc.append(AppDescription(type: "chart", top: "차트", middle: $0.rank ?? "", bottom: $0.genre ?? "", rating: 0.0))
            appDesc.append(AppDescription(type: "dev", top: "개발자", middle: "", bottom: $0.companyName ?? "", rating: 0.0))
            if let lang = $0.lang, !lang.isEmpty {
                appDesc.append(AppDescription(type: "lang", top: "언어", middle: lang[0], bottom: "", rating: 0.0))
            }
            return AppInfo(appIcon: $0.appIcon ?? "",
                            appTitle: $0.appTitle ?? "",
                            summary: $0.summary ?? "",
                            rating: $0.rating ?? 0.0,
                            info: appDesc,
                            version: $0.version ?? "",
                            updateDate: $0.updateDate ?? "",
                            history: $0.history ?? "",
                            previewImage: $0.previewImage ?? [],
                            guide: $0.guide ?? "",
                            companyName: $0.companyName ?? "",
                            vote: $0.vote ?? 0)
        }
    }
    
    func requestSearch(keyword: String) -> AnyPublisher<[AppInfo], TraceError> {
        Log.Debug(.INFRA, "keyword : \(keyword)")
        
        var urlComponents = URLComponents(string: "https://itunes.apple.com/search?")
        urlComponents?.queryItems = [
            URLQueryItem(name: "term", value: keyword),
            URLQueryItem(name: "entity", value: "software"),
            URLQueryItem(name: "country", value: "kr")
        ]
        
        guard let requestURL = urlComponents?.url else {
            let fail = Fail<[AppInfo], TraceError>(error: TraceError(message: "failed to create url request..."))
            return fail.eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: requestURL)
            .map { $0.data }
            .decode(type: AppStoreSearchApiResponse.self, decoder: JSONDecoder())
            .compactMap { convertData(from: $0.results) }
            .mapError { TraceError(message: $0.localizedDescription) }
            .eraseToAnyPublisher()
    }
}
