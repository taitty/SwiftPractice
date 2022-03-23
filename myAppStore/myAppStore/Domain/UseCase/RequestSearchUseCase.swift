//
//  RequestSearchUseCase.swift
//  myAppStore
//
//  Created by 김희수 on 2022/03/21.
//

import Foundation
import ReactiveSwift

class RequestSearchUseCase {
    
    private let dataSource: AppStoreDataSourceProtocol?
    private var disposables = CompositeDisposable()
    
    init(dataSource: AppStoreDataSourceProtocol) {
        self.dataSource = dataSource
    }
    
    func execute(keyword: String) -> SignalProducer<[SearchModel], TraceError> {
        return SignalProducer { [weak self] observer, _ in
            guard let self = self else {
                observer.send(error: TraceError(message: "already deinitialized..."))
                return
            }
            Log.Debug(.DOMAIN, keyword)
            guard let dataSource = self.dataSource else {
                observer.send(error: TraceError(message: "dataSource is not installed..."))
                return
            }
            self.disposables += dataSource.getData(keyword: keyword).startWithResult { result in
                switch result {
                case .success(let data):
                    Log.Debug(.DOMAIN, String(describing: data))
                    observer.send(value: data)
                case .failure(let error):
                    observer.send(error: error)
                }
            }
        }
    }
}
