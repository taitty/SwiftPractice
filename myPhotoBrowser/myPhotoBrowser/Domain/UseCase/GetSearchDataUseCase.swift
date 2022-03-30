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
    
    private var dataSource: UnsplashDataSourceProtocol?
    
    init(dataSource: UnsplashDataSourceProtocol) {
        self.dataSource = dataSource
    }
    
    deinit {
        Log.Debug(.DOMAIN, "")
    }
    
    func receive<S>(subscriber: S) where S : Subscriber, TraceError == S.Failure, [PhotoInfo] == S.Input {
        DispatchQueue.global(qos: .background).async {
            guard let dataSource = self.dataSource else {
                subscriber.receive(completion: .failure(TraceError(message: "dataSource is not created...")))
                return
            }
            let data = dataSource.getSearchResult()
            _ = subscriber.receive(data)
            subscriber.receive(completion: .finished)
        }
    }
}
