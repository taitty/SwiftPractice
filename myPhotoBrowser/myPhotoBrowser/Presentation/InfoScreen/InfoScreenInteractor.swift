//
//  InfoScreenInteractor.swift
//  myPhotoBrowser
//
//  Created by 김희수 on 2022/03/30.
//

import Foundation
import Combine

protocol InfoScreenInteractorProtocol {
    var dataPublisher: Published<PhotoDetail>.Publisher { get }
    
    func getDetailData()
}

final class InfoScreenInteractor {
    
    var dataSource: UnsplashDataSourceProtocol?
    var contentId: String?
    var cancellable = Set<AnyCancellable>()
    var dataPublisher: Published<PhotoDetail>.Publisher { $viewData }
    @Published var viewData = PhotoDetail()
    
    deinit {
        Log.Debug(.UI, "")
    }
    
}

extension InfoScreenInteractor: InfoScreenInteractorProtocol {
    
    func getDetailData() {
        guard let dataSource = self.dataSource, let contentId = self.contentId else {
            Log.Debug(.UI, "dataSource is not set in BrowseScreen")
            return
        }
        
        let useCase = GetDetailDataUseCase(dataSource: dataSource, photoId: contentId)
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
