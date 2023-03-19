//
//  CancelSearchUsecase.swift
//  myAppSearch
//
//  Created by 김희수 on 2023/03/20.
//

import Foundation

struct CancelSearchUsecase {
    private let dataSource: AppStoreRequirement
    
    init(dataSource: AppStoreRequirement) {
        self.dataSource = dataSource
    }
    
    func execute() {
        Log.Debug(.DOMAIN, "")
        dataSource.cancelSearch()
    }
}
