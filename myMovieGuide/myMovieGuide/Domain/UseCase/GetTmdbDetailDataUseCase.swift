//
//  GetTmdbDetailDataUseCase.swift
//  myMovieGuide
//
//  Created by 김희수 on 2022/02/22.
//

import ReactiveSwift
import UIKit

class GetTmdbDetailDataUseCase: UseCaseProtocol {
    
    typealias Param = String
    typealias ReturnType = SignalProducer<MovieGuideContentData, TraceError>
    
    private var disposables = CompositeDisposable()
    
    deinit {
        disposables.dispose()
        Log.Debug(.DOMAIN, "")
    }

    private func convertData(from: TmdbDataContent) -> MovieGuideContentData {
        return MovieGuideContentData(id: from.id,
                                     title: from.title,
                                     description: from.description,
                                     director: from.director,
                                     actor: from.actors?.joined(separator: ", "),
                                     voting: from.voting,
                                     imgPath: from.imagePath,
                                     releaseDate: from.releaseDate,
                                     genres: from.genres,
                                     runtime: from.runtime)
    }
    
    func execute(_ param: String) -> SignalProducer<MovieGuideContentData, TraceError> {
        return SignalProducer { observer, _ in
            guard let dataSource = try? DIContainer.resolve(TmdbDataSourceProtocol.self) else {
                observer.send(error: TraceError(message: "TmdbDataSourceProtocol is not registered"))
                return
            }
                
            self.disposables += dataSource.getContentDetail(id: param).startWithResult { result in
                switch result {
                case .success(let value):
                    Log.Debug(.SERVER, "success to get data from DataSource")
                    observer.send(value: self.convertData(from: value))
                case .failure(let error):
                    observer.send(error: error)
                }
            }
        }
    }
    
}
