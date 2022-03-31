//
//  BrowseScreenInteractor.swift
//  myPhotoBrowser
//
//  Created by 김희수 on 2022/03/30.
//

import Foundation
import Combine

protocol BrowseScreenInteractorProtocol {
    var dataPublisher: Published<[PhotoInfo]>.Publisher { get }
    func getHomeData()
}

final class BrowseScreenInteractor {
    
    var dataSource: UnsplashDataSourceProtocol?
    var cancellable = Set<AnyCancellable>()
    var dataPublisher: Published<[PhotoInfo]>.Publisher { $viewData }
    @Published var viewData: [PhotoInfo] = []
    
    deinit {
        Log.Debug(.UI, "")
    }
}

extension BrowseScreenInteractor: BrowseScreenInteractorProtocol {
    
    func getHomeData() {
        guard let dataSource = self.dataSource else {
            Log.Debug(.UI, "dataSource is not set in BrowseScreen")
            return
        }
        
        let useCase = GetHomeDataUseCase(dataSource: dataSource)
        useCase.sink(receiveCompletion: { result in
            switch result {
            case .finished:
                Log.Debug(.UI, "done to get homeData...")
            case .failure(let error):
                Log.Debug(.UI, error.message)
            }
        }, receiveValue: { value in
            self.viewData = value
        }).store(in: &cancellable)
    }
    
}
