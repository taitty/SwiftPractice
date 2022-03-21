//
//  AppStoreDataSource.swift
//  myAppStore
//
//  Created by 김희수 on 2022/03/21.
//

import Foundation
import ReactiveSwift

class AppStoreSearchApiModel: Decodable {
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

class AppStoreSearchApiResponse: Decodable {
    var results: [AppStoreSearchApiModel]?
}

class AppStoreDataSource: AppStoreDataSourceProtocol {

    private func convertData(from: [AppStoreSearchApiModel]) -> [SearchModel] {
        from.compactMap {
            var appInfo: [AppInfo]? = []
            let rating = round(($0.rating ?? 0) * 10) / 10
            appInfo?.append(AppInfo(type: "rating", top: "평가", middle: String(rating), rating: rating))
            appInfo?.append(AppInfo(type: "age", top: "연령", middle: $0.age, bottom: "세"))
            appInfo?.append(AppInfo(type: "chart", top: "차트", middle: $0.rank, bottom: $0.genre))
            appInfo?.append(AppInfo(type: "dev", top: "개발자", bottom: $0.companyName))
            if let lang = $0.lang, !lang.isEmpty {
                appInfo?.append(AppInfo(type: "lang", top: "언어", middle: lang[0]))
            }
            return SearchModel(appIcon: $0.appIcon,
                               appTitle: $0.appTitle,
                               summary: $0.summary,
                               rating: $0.rating,
                               info: appInfo,
                               version: $0.version,
                               updateDate: $0.updateDate,
                               history: $0.history,
                               previewImage: $0.previewImage,
                               guide: $0.guide,
                               companyName: $0.companyName)
        }
    }
    
    func getData(keyword: String) -> SignalProducer<[SearchModel], TraceError> {
        return SignalProducer { observer, _ in
            var urlComponents = URLComponents(string: "https://itunes.apple.com/search?")
            let keyword = URLQueryItem(name: "term", value: keyword)
            let entity = URLQueryItem(name: "entity", value: "software")
            let country = URLQueryItem(name: "country", value: "kr")
            urlComponents?.queryItems?.append(keyword)
            urlComponents?.queryItems?.append(entity)
            urlComponents?.queryItems?.append(country)
            guard let requestURL = urlComponents?.url else {
                Log.Debug(.SERVER, "failed to create url request...")
                return
            }
            let session = URLSession(configuration: .default)
            session.dataTask(with: requestURL) { data, response, error in
                let successRange = 200..<300
                guard error == nil,
                      let statusCode = (response as? HTTPURLResponse)?.statusCode,
                      successRange.contains(statusCode) else {
                          observer.send(error: TraceError(message: "[error]:\(String(describing: error?.localizedDescription))"))
                          return
                }
                
                guard let resultData = data else {
                    observer.send(error: TraceError(message: "data is nil..."))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(AppStoreSearchApiResponse.self, from: resultData)
                    
                    guard let data = response.results else {
                        return observer.send(error: TraceError(message: "failed to parse response"))
                    }
                    
                    observer.send(value: self.convertData(from: data))
                    observer.sendCompleted()
                } catch let error {
                    observer.send(error: TraceError(message: error.localizedDescription))
                }
            }.resume()
        }
    }
    
}
