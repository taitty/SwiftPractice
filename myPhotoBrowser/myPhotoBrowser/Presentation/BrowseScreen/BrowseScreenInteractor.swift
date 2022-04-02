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
    
    func getHomeData(mode: DataRequestMode)
    func requestSearch(keyword: String, mode: DataRequestMode)
    func requestMoreData(screenMode: ScreenMode, dataMode: DataRequestMode)
}

final class BrowseScreenInteractor {
    
    var dataSource: UnsplashDataSourceProtocol?
    var cancellable = Set<AnyCancellable>()
    var dataPublisher: Published<[PhotoInfo]>.Publisher { $viewData }
    
    @Published var viewData: [PhotoInfo] = []
    
    private var searchKeyword: String = ""
    
    deinit {
        Log.Debug(.UI, "")
    }
}

extension BrowseScreenInteractor: BrowseScreenInteractorProtocol {
    
    func getHomeData(mode: DataRequestMode) {
        guard let dataSource = self.dataSource else {
            Log.Debug(.UI, "dataSource is not set in BrowseScreen")
            return
        }
        
        let useCase = GetHomeDataUseCase(dataSource: dataSource, dataMode: mode)
        useCase.sink(receiveCompletion: { result in
            switch result {
            case .finished:
                Log.Debug(.UI, "done to get homeData...")
            case .failure(let error):
                Log.Debug(.UI, error.message)
            }
        }, receiveValue: { value in
            switch mode {
            case .initialData:
                self.viewData = value
            case .continueData:
                self.viewData += value
            }
        }).store(in: &cancellable)
    }
    
    func requestSearch(keyword: String, mode: DataRequestMode) {
        Log.Debug(.UI, "start search with \(keyword)")
        guard let dataSource = self.dataSource else {
            Log.Debug(.UI, "dataSource is not installed...")
            return
        }
        
        searchKeyword = keyword
        
        let useCase = GetSearchDataUseCase(dataSource: dataSource, keyword: keyword, dataMode: mode)
        useCase.sink(receiveCompletion: { result in
            switch result {
            case .finished:
                Log.Debug(.UI, "done to get searchData...")
            case .failure(let error):
                Log.Debug(.UI, error.message)
            }
        }, receiveValue: { value in
            switch mode {
            case .initialData:
                self.viewData = value
            case .continueData:
                self.viewData += value
            }
        }).store(in: &cancellable)
    }
    
    func requestMoreData(screenMode: ScreenMode, dataMode: DataRequestMode) {
        switch screenMode {
        case .browse:
            getHomeData(mode: dataMode)
        case .search:
            requestSearch(keyword: searchKeyword, mode: dataMode)
        }
    }
    
}
