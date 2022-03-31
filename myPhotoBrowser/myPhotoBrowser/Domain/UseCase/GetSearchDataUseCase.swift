//
//  GetSearchDataUseCase.swift
//  myPhotoBrowser
//
//  Created by 김희수 on 2022/03/30.
//

import Foundation
import Combine

class GetSearchDataUseCase: Publisher {
    
    typealias Output = [PhotoInfo]
    typealias Failure = TraceError
    
    private var dataSource: UnsplashDataSourceProtocol
    private var keyword: String
    
    var cancellable = Set<AnyCancellable>()
    
    init(dataSource: UnsplashDataSourceProtocol, keyword: String) {
        self.dataSource = dataSource
        self.keyword = keyword
    }
    
    deinit {
        Log.Debug(.DOMAIN, "")
    }
    
    func receive<S>(subscriber: S) where S : Subscriber, TraceError == S.Failure, [PhotoInfo] == S.Input {
        dataSource.getSearchResult(keyword: keyword).sink(
            receiveCompletion: { result in
                switch result {
                case .finished:
                    subscriber.receive(completion: .finished)
                case .failure(let error):
                    subscriber.receive(completion: .failure(TraceError(message: error.message)))
                }
            },
            receiveValue: { value in
                _ = subscriber.receive(value)
            }
        ).store(in: &cancellable)
    }
}
