//
//  GetDetailDataUseCase.swift
//  myPhotoBrowser
//
//  Created by 김희수 on 2022/03/30.
//

import Foundation
import Combine

class GetDetailDataUseCase: Publisher {
    
    typealias Output = PhotoDetail
    typealias Failure = TraceError
    
    private var dataSource: UnsplashDataSourceProtocol
    private var id: String
    
    var cancellable = Set<AnyCancellable>()
    
    init(dataSource: UnsplashDataSourceProtocol, photoId: String) {
        self.dataSource = dataSource
        self.id = photoId
    }
    
    deinit {
        Log.Debug(.DOMAIN, "")
    }
    
    func receive<S>(subscriber: S) where S : Subscriber, TraceError == S.Failure, PhotoDetail == S.Input {
        dataSource.getPhotoDetail(id: id).sink(
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
