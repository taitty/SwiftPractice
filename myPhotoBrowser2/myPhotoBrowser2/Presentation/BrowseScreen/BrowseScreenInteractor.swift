//
//  BrowseScreenInteractor.swift
//  myPhotoBrowser
//
//  Created by 김희수 on 2022/03/30.
//

import Foundation
import Combine

class BrowseScreenInteractor {
    
    private let dataSource: UnsplashDataSourceProtocol
    private var searchKeyword: String = ""
    private var cancellable = Set<AnyCancellable>()
    
    @Published var viewData: [PhotoInfo] = []
    
    init(dataSource: UnsplashDataSourceProtocol) {
        self.dataSource = dataSource
    }
    
    func getHomeData(page: Int) {
        let useCase = GetHomeDataUseCase(dataSource: dataSource, page: page)
        useCase.execute().sink(receiveCompletion: { result in
            switch result {
            case .finished:
                Log.Debug(.UI, "done to get homeData...")
            case .failure(let error):
                Log.Debug(.UI, error.message)
            }
        }, receiveValue: { value in
            switch page {
            case 0:
                self.viewData = value
            default:
                self.viewData += value
            }
        }).store(in: &cancellable)
    }
    
    func requestSearch(keyword: String, page: Int) {
        Log.Debug(.UI, "start search with \(keyword)")
        
        self.searchKeyword = keyword
        
        let useCase = GetSearchDataUseCase(dataSource: dataSource, keyword: keyword, page: page)
        useCase.execute().sink(receiveCompletion: { result in
            switch result {
            case .finished:
                Log.Debug(.UI, "done to get searchData...")
            case .failure(let error):
                Log.Debug(.UI, error.message)
            }
        }, receiveValue: { value in
            switch page {
            case 0:
                self.viewData = value
            default:
                self.viewData += value
            }
        }).store(in: &cancellable)
    }
    
    func requestMoreData(screenMode: ScreenMode, page: Int) {
        switch screenMode {
        case .browse:
            getHomeData(page: page)
        case .search:
            requestSearch(keyword: self.searchKeyword, page: page)
        }
    }
    
}
