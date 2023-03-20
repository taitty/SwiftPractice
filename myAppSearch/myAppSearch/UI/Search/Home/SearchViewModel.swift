//
//  SearchViewModel.swift
//  myAppSearch
//
//  Created by 김희수 on 2023/03/20.
//

import Foundation
import Combine

struct SearchResultEntity {
    let icon: String
    let title: String
    let subTitle: String
    let rating: String
    let user: String
    let preview: [String]
}

class SearchViewModel {
    @Published var viewData = [SearchResultEntity]()
    private var cancellable = Set<AnyCancellable>()
    
    func requestSearch(keyword: String) {
        Log.Debug(.UI, "keyword : \(keyword)")
        
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
            })
        .store(in: &cancellable)
    }
}
