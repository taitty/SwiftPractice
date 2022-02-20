//
//  TmdbDataSource.swift
//  myMovieGuide
//
//  Created by 김희수 on 2022/02/07.
//

import Foundation
import Alamofire
import ReactiveSwift

enum TmdbEndPoint: String {
    case configuration
    case popular
    case nowPlaying
    case upComing
    
    var url: String {
        switch self {
        case .configuration:
            return "/configuration"
        case .popular:
            return "/movie/popular"
        case .nowPlaying:
            return "/movie/now_playing"
        case .upComing:
            return "/movie/upcoming"
        }
    }
}

enum TmdbBaseRequest: String {
    case endPoint
    case apiKey
    
    var url: String {
        switch self {
        case .endPoint:
            return "https://api.themoviedb.org/3"
        case .apiKey:
            return "620adaf60ebc1f8a0a4e88ca439f04ce"
        }
    }
}

enum TmdbConnectionStatus {
    case notConnected
    case connecting
    case connected
}

struct TmdbImageConfig: Decodable {
    var secure_base_url: String?
    var poster_sizes: [String]?
}

struct TmdbConfigData: Decodable {
    var images: TmdbImageConfig?
}

struct TmdbHomeContent: Decodable {
    var id: Int?
    var title: String?
    var voting: Double?
    var posterId: String?
    var releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case voting = "vote_average"
        case posterId = "poster_path"
        case releaseDate = "release_date"
    }
}

struct TmdbContentListData: Decodable {
    var results: [TmdbHomeContent]?
}

class TmdbDataSource: TmdbDataSourceProtocol {
    
    private var imageUrl: String? {
        didSet {
            status.value = .connected
        }
    }
    private var status = MutableProperty<TmdbConnectionStatus>(.notConnected)
    private var disposables = CompositeDisposable()
    
    init() {
        getConfiguration()
    }
    
    deinit {
        disposables.dispose()
        Log.Debug(.SERVER, "")
    }
    
    private func getBaseUrl(key: TmdbEndPoint) -> String {
        let urlString = TmdbBaseRequest.endPoint.url.appending(key.url)
        return urlString
    }
    
    private func getParams(key: TmdbEndPoint) -> [String: Any] {
        var params: [String: Any] = [:]
        switch key {
        case .configuration:
            params.updateValue(TmdbBaseRequest.apiKey.url, forKey: "api_key")
        case .popular, .nowPlaying, .upComing:
            params.updateValue(TmdbBaseRequest.apiKey.url, forKey: "api_key")
            params.updateValue("ko-KR", forKey: "language")
            params.updateValue("1", forKey: "page")
            params.updateValue("KR", forKey: "region")
        }
        return params
    }
    
    private func getConfiguration() {
        let url = getBaseUrl(key: .configuration)
        let params = getParams(key: .configuration)
        AF.request(url, parameters: params).responseDecodable(of: TmdbConfigData.self) { response in
            switch response.result {
            case .success(let response):
                Log.Debug(.SERVER, "success to get config from TMDB : \(String(describing: response.images?.secure_base_url))")
                self.imageUrl = response.images?.secure_base_url
            case .failure(let error):
                Log.Debug(.SERVER, "\(error.localizedDescription)")
            }
        }
    }
    
    private func convertData(from: TmdbContentListData) -> [TmdbDataContent] {
        from.results?.compactMap { TmdbDataContent(id: $0.id,
                                                   title: $0.title,
                                                   imgPath: imageUrl?.appending($0.posterId ?? ""),
                                                   voting: Int($0.voting ?? 0 * 10))
        } ?? []
    }
    
    func getContentList(type: TmdbDataCategory) -> SignalProducer<TmdbData, TraceError> {
        return SignalProducer { observer, _ in
            self.disposables += self.status.producer
                .skip(while: { $0 != .connected })
                .startWithValues { _ in
                    guard let key = TmdbEndPoint(rawValue: type.rawValue) else {
                        observer.send(error: TraceError(message: "requested category is invalid"))
                        return
                    }
                    
                    let url = self.getBaseUrl(key: key)
                    let params = self.getParams(key: key)
                    AF.request(url, parameters: params).responseDecodable(of: TmdbContentListData.self) { response in
                        switch response.result {
                        case .success(let response):
                            Log.Debug(.SERVER, "success to get data from TMDB")
                            observer.send(value: TmdbData(type: type, data: self.convertData(from: response)))
                            observer.sendCompleted()
                        case .failure(let error):
                            Log.Debug(.SERVER, "\(error.localizedDescription)")
                        }
                    }
                }
        }
    }
    
}
