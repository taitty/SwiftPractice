//
//  GetHomeDataUseCase.swift
//  myPhotoBrowser
//
//  Created by 김희수 on 2022/03/30.
//

import Foundation
import Combine

class GetHomeDataUseCase: Publisher {
    
    typealias Output = [PhotoInfo]
    typealias Failure = TraceError
    
    private var dataSource: UnsplashDataSourceProtocol
    private var dataMode: DataRequestMode
    private var status = false
    
    var cancellable = Set<AnyCancellable>()
    
    init(dataSource: UnsplashDataSourceProtocol, dataMode: DataRequestMode) {
        self.dataSource = dataSource
        self.dataMode = dataMode
    }
    
    deinit {
        Log.Debug(.DOMAIN, "")
    }
    
    func receive<S>(subscriber: S) where S : Subscriber, TraceError == S.Failure, [PhotoInfo] == S.Input {
        dataSource.getPhotoList(mode: dataMode).sink(
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
                self.status = true
            }
        ).store(in: &cancellable)
    }
    
}
