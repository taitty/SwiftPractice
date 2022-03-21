//
//  AppStoreDataSource.swift
//  myAppStore
//
//  Created by 김희수 on 2022/03/21.
//

import Foundation
import ReactiveSwift

class MoreInfo: Decodable {
    var text_1st: String?
    var text_2nd: String?
    var text_3rd: String?
}

class AppStoreSearchApiModel: Decodable {
    var appTitle: String?
    var appIcon: String?
    var summary: String?
    var rating: Double?
    var info: [MoreInfo]?
    var version: String?
    var updateDate: String?
    var history: String?
    var previewImage: [String]?
    var guide: String?
    var companyName: String?
    
    enum CodingKeys: String, CodingKey {
        case appTitle = "trackName"
        case appIcon = "artworkUrl100"
        case summary = "sellerName"
        case rating = "averageUserRating"
        case info
        case version
        case updateDate = "currentVersionReleaseDate"
        case history = "releaseNotes"
        case previewImage = "screenshotUrls"
        case guide = "description"
        case companyName = "artistName"
    }
}

class AppStoreSearchApiResponse: Decodable {
    var results: [AppStoreSearchApiModel]?
}

class AppStoreDataSource: AppStoreDataSourceProtocol {
    
    private func convertData(from: [AppStoreSearchApiModel]) -> [SearchModel] {
        from.compactMap {
            SearchModel(appIcon: $0.appIcon,
                        appTitle: $0.appTitle,
                        summary: $0.summary,
                        rating: $0.rating,
                        info: $0.info?.compactMap {
                            AppInfo(top: $0.text_1st,
                                    middle: $0.text_2nd,
                                    bottom: $0.text_3rd)
                        },
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
