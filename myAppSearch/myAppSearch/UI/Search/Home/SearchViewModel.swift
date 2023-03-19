//
//  SearchViewModel.swift
//  myAppSearch
//
//  Created by 김희수 on 2023/03/20.
//

import Foundation
import Combine

struct SearchViewModel {
    var cancellable = Set<AnyCancellable>()
    
    mutating func requestSearch(keyword: String) {
        Log.Debug(.UI, "keyword : \(keyword)")
        
        let usecase = RequestSearchUsecase(dataSource: AppContext.real.dataSource)
        usecase.execute(keyword: keyword).sink(
            receiveCompletion: { result in
                switch result {
                case .finished:
                    Log.Debug(.UI, "finish to get search result")
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
