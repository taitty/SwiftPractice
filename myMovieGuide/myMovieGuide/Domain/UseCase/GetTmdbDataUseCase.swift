//
//  GetTmdbDataUseCase.swift
//  myMovieGuide
//
//  Created by 김희수 on 2022/01/28.
//

import ReactiveSwift
import UIKit

class GetTmdbDataUseCase: UseCaseProtocol {
    
    typealias Param = TmdbDataType
    typealias ReturnType = SignalProducer<[MovieGuideContentList], TraceError>
    
    private var disposables = CompositeDisposable()
    private var test: Int?
    private var tmdbData: [MovieGuideContentList] = []
    
    deinit {
        disposables.dispose()
        Log.Debug(.DOMAIN, "")
    }

    private func convertData(from: [TmdbDataContent]) -> [MovieGuideContentData] {
        from.compactMap { MovieGuideContentData(id: $0.id,
                                                title: $0.title,
                                                voting: $0.voting,
                                                imgPath: $0.imagePath)
        }
    }
    
    func execute(_ param: TmdbDataType) -> SignalProducer<[MovieGuideContentList], TraceError> {
        switch param {
        case .contentList:
            return getContentList()
        case .contentDetail:
            return getContentDetail()
        }

    }
    
    func getContentList() -> SignalProducer<[MovieGuideContentList], TraceError> {
        return SignalProducer { observer, _ in
            guard let dataSource = try? DIContainer.resolve(TmdbDataSourceProtocol.self) else {
                observer.send(error: TraceError(message: "TmdbDataSourceProtocol is not registered"))
                return
            }

            MovieGuideCategory.allCases.forEach { category in
                guard let category = TmdbDataCategory(rawValue: category.rawValue) else {
                    observer.send(error: TraceError(message: "category is invalid"))
                    return
                }
                
                self.disposables += dataSource.getContentList(type: category).startWithResult { result in
                    switch result {
                    case .success(let value):
                        Log.Debug(.SERVER, "success to get data from DataSource")
                        guard let category = MovieGuideCategory(rawValue: value.type.rawValue) else {
                            observer.send(error: TraceError(message: "category is invalid"))
                            return
                        }
                        
                        self.tmdbData.append(MovieGuideContentList(category: category, data: self.convertData(from: value.data)))
                        observer.send(value: self.tmdbData)
                    case .failure(let error):
                        observer.send(error: error)
                    }
                }
            }
        }
    }
    
    //TODO: it should be implemented about detail information
    func getContentDetail() -> SignalProducer<[MovieGuideContentList], TraceError> {
        return SignalProducer { observer, _ in
            guard let dataSource = try? DIContainer.resolve(TmdbDataSourceProtocol.self) else {
                observer.send(error: TraceError(message: "TmdbDataSourceProtocol is not registered"))
                return
            }

            MovieGuideCategory.allCases.forEach { category in
                guard let category = TmdbDataCategory(rawValue: category.rawValue) else {
                    observer.send(error: TraceError(message: "category is invalid"))
                    return
                }
                
                self.disposables += dataSource.getContentList(type: category).startWithResult { result in
                    switch result {
                    case .success(let value):
                        Log.Debug(.SERVER, "success to get data from DataSource")
                        guard let category = MovieGuideCategory(rawValue: value.type.rawValue) else {
                            observer.send(error: TraceError(message: "category is invalid"))
                            return
                        }
                        
                        self.tmdbData.append(MovieGuideContentList(category: category, data: self.convertData(from: value.data)))
                        observer.send(value: self.tmdbData)
                    case .failure(let error):
                        observer.send(error: error)
                    }
                }
            }
        }
    }
}
