//
//  SearchViewModel.swift
//  myAppSearch
//
//  Created by 김희수 on 2023/03/20.
//

import Foundation
import Combine

struct SearchResultEntity {
    let appIcon: String
    let appTitle: String
    let summary: String
    let rating: Double
    let vote: Int
    let previewImage: [String]
}

class SearchViewModel {
    @Published var viewData = [SearchResultEntity]()
    @Published var matchKeyword = [String]()
    
    var baseData = [AppInfo]()
    var searchHistory = [String]()
    
    private var cancellable = Set<AnyCancellable>()
    
    func requestSearch(keyword: String) {
        Log.Debug(.UI, "keyword : \(keyword)")
        
        if !searchHistory.contains(keyword) {
            searchHistory.append(keyword)
        }
        
        let usecase = RequestSearchUsecase(dataSource: AppContext.real.dataSource)
        usecase.execute(keyword: keyword).sink(
            receiveCompletion: { result in
                switch result {
                case .finished:
                    Log.Debug(.UI, "success to get search result")
                case .failure(let error):
                    Log.Debug(.UI, "\(error.message)")
                }
            },
            receiveValue: { searchData in
                Log.Debug(.UI, "\(searchData)")
                self.baseData = searchData
                self.viewData = searchData.compactMap { data in
                    return SearchResultEntity(appIcon: data.appIcon, appTitle: data.appTitle, summary: data.summary, rating: data.rating, vote: data.vote, previewImage: data.previewImage)
                }
            })
        .store(in: &cancellable)
    }
    
    func requestClear() {
        DispatchQueue.main.async {
            self.baseData.removeAll()
            self.viewData.removeAll()
        }
    }
    
    func searchKeyword(text: String) {
        matchKeyword.removeAll()
        searchHistory.forEach {
            if $0.starts(with: text) {
                matchKeyword.append($0)
            }
        }
    }
}
