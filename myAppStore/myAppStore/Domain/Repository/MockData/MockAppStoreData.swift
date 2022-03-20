//
//  MockAppStoreData.swift
//  myAppStore
//
//  Created by 김희수 on 2022/03/21.
//

import Foundation
import ReactiveSwift

class MockAppStoreData {

    private let dummy_searchModel: [SearchModel] = [
        SearchModel(appIcon: "https://img.icons8.com/cute-clipart/344/very-popular-topic.png",
                    appTitle: "Sample",
                    summary: "Mock Data 용 Sample",
                    rating: 3.5,
                    preview: [
                        "https://www.combell.com/en/help/wp-content/uploads/5981c6d9f0f4baa8678b457f.png",
                        "https://www.combell.com/en/help/wp-content/uploads/5981c6d9f0f4baa8678b457f.png",
                        "https://www.combell.com/en/help/wp-content/uploads/5981c6d9f0f4baa8678b457f.png"
                    ]),
        SearchModel(appIcon: "https://img.icons8.com/cute-clipart/344/very-popular-topic.png",
                    appTitle: "Sample",
                    summary: "Mock Data 용 Sample",
                    rating: 2.7,
                    preview: [
                        "https://www.combell.com/en/help/wp-content/uploads/5981c6d9f0f4baa8678b457f.png",
                        "https://www.combell.com/en/help/wp-content/uploads/5981c6d9f0f4baa8678b457f.png",
                        "https://www.combell.com/en/help/wp-content/uploads/5981c6d9f0f4baa8678b457f.png"
                    ]),
        SearchModel(appIcon: "https://img.icons8.com/cute-clipart/344/very-popular-topic.png",
                    appTitle: "Sample",
                    summary: "Mock Data 용 Sample",
                    rating: 3.1,
                    preview: [
                        "https://www.combell.com/en/help/wp-content/uploads/5981c6d9f0f4baa8678b457f.png",
                        "https://www.combell.com/en/help/wp-content/uploads/5981c6d9f0f4baa8678b457f.png",
                        "https://www.combell.com/en/help/wp-content/uploads/5981c6d9f0f4baa8678b457f.png"
                    ]),
        SearchModel(appIcon: "https://img.icons8.com/cute-clipart/344/very-popular-topic.png",
                    appTitle: "Sample",
                    summary: "Mock Data 용 Sample",
                    rating: 3,
                    preview: [
                        "https://www.combell.com/en/help/wp-content/uploads/5981c6d9f0f4baa8678b457f.png",
                        "https://www.combell.com/en/help/wp-content/uploads/5981c6d9f0f4baa8678b457f.png",
                        "https://www.combell.com/en/help/wp-content/uploads/5981c6d9f0f4baa8678b457f.png"
                    ]),
        SearchModel(appIcon: "https://img.icons8.com/cute-clipart/344/very-popular-topic.png",
                    appTitle: "Sample",
                    summary: "Mock Data 용 Sample",
                    rating: 1.3,
                    preview: [
                        "https://www.combell.com/en/help/wp-content/uploads/5981c6d9f0f4baa8678b457f.png",
                        "https://www.combell.com/en/help/wp-content/uploads/5981c6d9f0f4baa8678b457f.png",
                        "https://www.combell.com/en/help/wp-content/uploads/5981c6d9f0f4baa8678b457f.png"
                    ]),
    ]
    
    func getData() -> [SearchModel] {
        return dummy_searchModel
    }
}
