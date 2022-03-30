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
    
    private var dataSource: UnsplashDataSourceProtocol?
    
    init(dataSource: UnsplashDataSourceProtocol) {
        self.dataSource = dataSource
    }
    
    deinit {
        Log.Debug(.DOMAIN, "")
    }
    
    func receive<S>(subscriber: S) where S : Subscriber, TraceError == S.Failure, PhotoDetail == S.Input {
        DispatchQueue.global(qos: .background).async {
            guard let dataSource = self.dataSource else {
                subscriber.receive(completion: .failure(TraceError(message: "dataSource is not created...")))
                return
            }
            let data = dataSource.getPhotoDetail()
            _ = subscriber.receive(data)
            subscriber.receive(completion: .finished)
        }
    }
}
