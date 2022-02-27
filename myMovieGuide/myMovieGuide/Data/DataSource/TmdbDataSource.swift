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
    case nowplaying
    case upcoming
    case detail
    case credits
    
    var url: String {
        switch self {
        case .configuration:
            return "/configuration"
        case .popular:
            return "/movie/popular"
        case .nowplaying:
            return "/movie/now_playing"
        case .upcoming:
            return "/movie/upcoming"
        case .detail:
            return "/movie/{id}"
        case .credits:
            return "/movie/{id}/credits"
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

struct TmdbContentDetailGenres: Decodable {
    var id: Int?
    var name: String?
}

struct TmdbContentDetailData: Decodable {
    var id: Int?
    var title: String?
    var imgPath: String?
    var genres: [TmdbContentDetailGenres]?
    var description: String?
    var releaseDate: String?
    var runtime: Int?
    var voting: Double?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case imgPath = "backdrop_path"
        case genres
        case description = "overview"
        case releaseDate = "release_date"
        case runtime
        case voting = "vote_average"
    }
}

struct TmdbContentArtistData: Decodable {
    var director: String?
    var actors: [String]?
}

struct TmdbContentMemberData: Decodable {
    var name: String?
    var job: String?
}

struct TmdbContentCreditData: Decodable {
    var cast: [TmdbContentMemberData]?
    var crew: [TmdbContentMemberData]?
}

class TmdbDataSource: TmdbDataSourceProtocol {
    
    private var imageUrl: String? {
        didSet {
            status.value = .connected
        }
    }
    private var imageSize: String?
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
        case .popular, .nowplaying, .upcoming:
            params.updateValue(TmdbBaseRequest.apiKey.url, forKey: "api_key")
            params.updateValue("ko-KR", forKey: "language")
            params.updateValue("1", forKey: "page")
            params.updateValue("KR", forKey: "region")
        case .detail, .credits:
            params.updateValue(TmdbBaseRequest.apiKey.url, forKey: "api_key")
            params.updateValue("ko-KR", forKey: "language")
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
                self.imageSize = response.images?.poster_sizes?.first
            case .failure(let error):
                Log.Debug(.SERVER, "\(error.localizedDescription)")
            }
        }
    }
    
    private func convertFromCategoryData(from: TmdbContentListData) -> [TmdbDataContent] {
        from.results?.compactMap { TmdbDataContent(id: $0.id,
                                                   title: $0.title,
                                                   imgPath: imageUrl?.appending(imageSize ?? "").appending($0.posterId ?? ""),
                                                   voting: String(Int(($0.voting ?? 0.0) * 10)),
                                                   releaseDate: $0.releaseDate)
        } ?? []
    }
    
    func getContentList(type: TmdbDataCategory) -> SignalProducer<TmdbData, TraceError> {
        return SignalProducer { observer, _ in
            self.disposables += self.status.producer
                .skip(while: { $0 != .connected })
                .startWithValues { _ in
                    guard let key = TmdbEndPoint(rawValue: type.toString) else {
                        observer.send(error: TraceError(message: "requested category is invalid"))
                        return
                    }
                    
                    let url = self.getBaseUrl(key: key)
                    let params = self.getParams(key: key)
                    AF.request(url, parameters: params).responseDecodable(of: TmdbContentListData.self) { response in
                        switch response.result {
                        case .success(let response):
                            Log.Debug(.SERVER, "success to get data from TMDB")
                            observer.send(value: TmdbData(type: type, data: self.convertFromCategoryData(from: response)))
                            observer.sendCompleted()
                        case .failure(let error):
                            Log.Debug(.SERVER, "\(error.localizedDescription)")
                        }
                    }
                }
        }
    }

    private func convertFromDetailNCreditsData(detail: TmdbContentDetailData, artists: TmdbContentArtistData) -> TmdbDataContent {
        return TmdbDataContent(id: detail.id,
                               title: detail.title,
                               imgPath: imageUrl?.appending(imageSize ?? "").appending(detail.imgPath ?? ""),
                               voting: String(Int((detail.voting ?? 0.0) * 10)),
                               releaseDate: detail.releaseDate,
                               genres: detail.genres?.compactMap { $0.name },
                               description: detail.description,
                               runtime: detail.runtime,
                               director: artists.director,
                               actors: artists.actors)
    }
    
    func getContentDetail(id: String) -> SignalProducer<TmdbDataContent, TraceError> {
        return SignalProducer { observer, _ in
            self.disposables += self.status.producer
                .skip(while: { $0 != .connected })
                .startWithValues { _ in
                    self.disposables += SignalProducer.combineLatest(self.getDetails(id: id), self.getCredits(id: id))
                        .observe(on: UIScheduler())
                        .startWithResult { result in
                            switch result {
                            case .success((let details, let artists)):
                                observer.send(value: self.convertFromDetailNCreditsData(detail: details, artists: artists))
                            case .failure(let error):
                                Log.Debug(.SERVER, "\(error.message)")
                            }
                        }
                }
        }
    }
    
    private func getDetails(id: String) -> SignalProducer<TmdbContentDetailData, TraceError> {
        return SignalProducer { observer, _ in
            let url = self.getBaseUrl(key: .detail).replacingOccurrences(of: "{id}", with: id)
            let params = self.getParams(key: .detail)
            AF.request(url, parameters: params).responseDecodable(of: TmdbContentDetailData.self) { response in
                switch response.result {
                case .success(let response):
                    Log.Debug(.SERVER, "success to get data from TMDB")
                    observer.send(value: response)
                    observer.sendCompleted()
                case .failure(let error):
                    Log.Debug(.SERVER, "\(error.localizedDescription)")
                }
            }
        }
    }
    
    private func fetchData(data: TmdbContentCreditData) -> TmdbContentArtistData {
        var artists = TmdbContentArtistData()
        data.crew?.forEach { crew in
            if crew.job == "Director" {
                artists.director = crew.name
            }
        }
        artists.actors = data.cast?.compactMap { $0.name }
        return artists
    }
    
    private func getCredits(id: String) -> SignalProducer<TmdbContentArtistData, TraceError> {
        return SignalProducer { observer, _ in
            let url = self.getBaseUrl(key: .credits).replacingOccurrences(of: "{id}", with: id)
            let params = self.getParams(key: .credits)
            AF.request(url, parameters: params).responseDecodable(of: TmdbContentCreditData.self) { response in
                switch response.result {
                case .success(let response):
                    Log.Debug(.SERVER, "success to get data from TMDB")
                    observer.send(value: self.fetchData(data: response))
                    observer.sendCompleted()
                case .failure(let error):
                    Log.Debug(.SERVER, "\(error.localizedDescription)")
                }
            }
        }
    }
    
}
