//
//  MockAppStoreDataSource.swift
//  myAppSearch
//
//  Created by 김희수 on 2023/03/20.
//

import Foundation
import Combine

struct MockAppStoreDataSource: AppStoreRequirement {
    func requestSearch(keyword: String) -> AnyPublisher<[AppInfo], TraceError> {
        Log.Debug(.INFRA, "keyword : \(keyword)")
        
        if keyword == "오류" {
            return Fail<[AppInfo], TraceError>(error: TraceError(message: "failed to create url request...")).eraseToAnyPublisher()
        } else {
            return Just(MockAppStoreData().getData()).mapError { error -> TraceError in }.eraseToAnyPublisher()
        }
    }
}

struct MockAppStoreData {
    private let dummy_searchModel: [AppInfo] = [
        AppInfo(appIcon: "https://i.pinimg.com/originals/27/bb/a2/27bba208a1f0a54544aed6a66e5e3331.png",
                appTitle: "Sample",
                summary: "Mock Data 용 Sample",
                rating: 3.0,
                info: [
                    AppDescription(type: "rating", top: "Test", middle: "Test", bottom: "Test", rating: 3.0),
                    AppDescription(type: "age", top: "Test", middle: "Test", bottom: "Test", rating: 3.0),
                    AppDescription(type: "chart", top: "Test", middle: "Test", bottom: "Test", rating: 3.0),
                    AppDescription(type: "dev", top: "Test", middle: "Test", bottom: "Test", rating: 3.0),
                    AppDescription(type: "lang", top: "Test", middle: "Test", bottom: "Test", rating: 3.0)
                ],
                version: "0.0.1",
                updateDate: "2022-03-21",
                history: "테스트용 히스토리. 테스트 중...",
                previewImage: [
                    "https://i.pinimg.com/736x/18/d0/b2/18d0b2f08e4a20ec0c6d67c57ff8e37c.jpg",
                    "https://i.pinimg.com/736x/18/d0/b2/18d0b2f08e4a20ec0c6d67c57ff8e37c.jpg",
                    "https://i.pinimg.com/736x/18/d0/b2/18d0b2f08e4a20ec0c6d67c57ff8e37c.jpg",
                    "https://i.pinimg.com/736x/18/d0/b2/18d0b2f08e4a20ec0c6d67c57ff8e37c.jpg",
                    "https://i.pinimg.com/736x/18/d0/b2/18d0b2f08e4a20ec0c6d67c57ff8e37c.jpg"
                ],
                guide: "테스트용 가이드. 테스트 중...",
                companyName: "My Home",
                vote: 10),
        AppInfo(appIcon: "https://i.pinimg.com/originals/27/bb/a2/27bba208a1f0a54544aed6a66e5e3331.png",
                appTitle: "Sample",
                summary: "Mock Data 용 Sample",
                rating: 3.0,
                info: [
                    AppDescription(type: "rating", top: "Test", middle: "Test", bottom: "Test", rating: 3.0),
                    AppDescription(type: "age", top: "Test", middle: "Test", bottom: "Test", rating: 3.0),
                    AppDescription(type: "chart", top: "Test", middle: "Test", bottom: "Test", rating: 3.0),
                    AppDescription(type: "dev", top: "Test", middle: "Test", bottom: "Test", rating: 3.0),
                    AppDescription(type: "lang", top: "Test", middle: "Test", bottom: "Test", rating: 3.0)
                ],
                version: "0.0.1",
                updateDate: "2022-03-21",
                history: "테스트용 히스토리. 테스트 중...",
                previewImage: [
                    "https://i.pinimg.com/736x/18/d0/b2/18d0b2f08e4a20ec0c6d67c57ff8e37c.jpg",
                    "https://i.pinimg.com/736x/18/d0/b2/18d0b2f08e4a20ec0c6d67c57ff8e37c.jpg",
                    "https://i.pinimg.com/736x/18/d0/b2/18d0b2f08e4a20ec0c6d67c57ff8e37c.jpg",
                    "https://i.pinimg.com/736x/18/d0/b2/18d0b2f08e4a20ec0c6d67c57ff8e37c.jpg",
                    "https://i.pinimg.com/736x/18/d0/b2/18d0b2f08e4a20ec0c6d67c57ff8e37c.jpg"
                ],
                guide: "테스트용 가이드. 테스트 중...",
                companyName: "My Home",
                vote: 10)
    ]
    
    func getData() -> [AppInfo] {
        return dummy_searchModel
    }
}
