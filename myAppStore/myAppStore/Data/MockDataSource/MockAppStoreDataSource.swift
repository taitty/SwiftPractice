//
//  MockAppStoreDataSource.swift
//  myAppStore
//
//  Created by 김희수 on 2022/03/21.
//

import Foundation
import ReactiveSwift

class MockAppStoreDataSource: AppStoreDataSourceProtocol {
    
    func getData(keyword: String) -> SignalProducer<[SearchModel], TraceError> {
        Log.Debug(.SERVER, "not implemented...")
        return SignalProducer { observer, _ in
            let mockDataSource = MockAppStoreData()
            observer.send(value: mockDataSource.getData())
            observer.sendCompleted()
        }
    }
    
}

class MockAppStoreData {
    
    private let dummy_searchModel: [SearchModel] = [
        SearchModel(appIcon: "https://i.pinimg.com/originals/27/bb/a2/27bba208a1f0a54544aed6a66e5e3331.png",
                    appTitle: "Sample",
                    summary: "Mock Data 용 Sample",
                    rating: 3.0,
                    info: [
                        AppInfo(type: "rating", top: "Test", middle: "Test", bottom: "Test", rating: 3.0),
                        AppInfo(type: "age", top: "Test", middle: "Test", bottom: "Test", rating: 3.0),
                        AppInfo(type: "chart", top: "Test", middle: "Test", bottom: "Test", rating: 3.0),
                        AppInfo(type: "dev", top: "Test", middle: "Test", bottom: "Test", rating: 3.0),
                        AppInfo(type: "lang", top: "Test", middle: "Test", bottom: "Test", rating: 3.0)
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
                    companyName: "My Home"),
        SearchModel(appIcon: "https://i.pinimg.com/originals/27/bb/a2/27bba208a1f0a54544aed6a66e5e3331.png",
                    appTitle: "Sample",
                    summary: "Mock Data 용 Sample",
                    rating: 3.0,
                    info: [
                        AppInfo(type: "rating", top: "Test", middle: "Test", bottom: "Test", rating: 3.0),
                        AppInfo(type: "age", top: "Test", middle: "Test", bottom: "Test", rating: 3.0),
                        AppInfo(type: "chart", top: "Test", middle: "Test", bottom: "Test", rating: 3.0),
                        AppInfo(type: "dev", top: "Test", middle: "Test", bottom: "Test", rating: 3.0),
                        AppInfo(type: "lang", top: "Test", middle: "Test", bottom: "Test", rating: 3.0)
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
                    companyName: "My Home"),
        SearchModel(appIcon: "https://i.pinimg.com/originals/27/bb/a2/27bba208a1f0a54544aed6a66e5e3331.png",
                    appTitle: "Sample",
                    summary: "Mock Data 용 Sample",
                    rating: 3.0,
                    info: [
                        AppInfo(type: "rating", top: "Test", middle: "Test", bottom: "Test", rating: 3.0),
                        AppInfo(type: "age", top: "Test", middle: "Test", bottom: "Test", rating: 3.0),
                        AppInfo(type: "chart", top: "Test", middle: "Test", bottom: "Test", rating: 3.0),
                        AppInfo(type: "dev", top: "Test", middle: "Test", bottom: "Test", rating: 3.0),
                        AppInfo(type: "lang", top: "Test", middle: "Test", bottom: "Test", rating: 3.0)
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
                    companyName: "My Home"),
        SearchModel(appIcon: "https://i.pinimg.com/originals/27/bb/a2/27bba208a1f0a54544aed6a66e5e3331.png",
                    appTitle: "Sample",
                    summary: "Mock Data 용 Sample",
                    rating: 3.0,
                    info: [
                        AppInfo(type: "rating", top: "Test", middle: "Test", bottom: "Test", rating: 3.0),
                        AppInfo(type: "age", top: "Test", middle: "Test", bottom: "Test", rating: 3.0),
                        AppInfo(type: "chart", top: "Test", middle: "Test", bottom: "Test", rating: 3.0),
                        AppInfo(type: "dev", top: "Test", middle: "Test", bottom: "Test", rating: 3.0),
                        AppInfo(type: "lang", top: "Test", middle: "Test", bottom: "Test", rating: 3.0)
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
                    companyName: "My Home"),
        SearchModel(appIcon: "https://i.pinimg.com/originals/27/bb/a2/27bba208a1f0a54544aed6a66e5e3331.png",
                    appTitle: "Sample",
                    summary: "Mock Data 용 Sample",
                    rating: 3.0,
                    info: [
                        AppInfo(type: "rating", top: "Test", middle: "Test", bottom: "Test", rating: 3.0),
                        AppInfo(type: "age", top: "Test", middle: "Test", bottom: "Test", rating: 3.0),
                        AppInfo(type: "chart", top: "Test", middle: "Test", bottom: "Test", rating: 3.0),
                        AppInfo(type: "dev", top: "Test", middle: "Test", bottom: "Test", rating: 3.0),
                        AppInfo(type: "lang", top: "Test", middle: "Test", bottom: "Test", rating: 3.0)
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
                    companyName: "My Home"),
        SearchModel(appIcon: "https://i.pinimg.com/originals/27/bb/a2/27bba208a1f0a54544aed6a66e5e3331.png",
                    appTitle: "Sample",
                    summary: "Mock Data 용 Sample",
                    rating: 3.0,
                    info: [
                        AppInfo(type: "rating", top: "Test", middle: "Test", bottom: "Test", rating: 3.0),
                        AppInfo(type: "age", top: "Test", middle: "Test", bottom: "Test", rating: 3.0),
                        AppInfo(type: "chart", top: "Test", middle: "Test", bottom: "Test", rating: 3.0),
                        AppInfo(type: "dev", top: "Test", middle: "Test", bottom: "Test", rating: 3.0),
                        AppInfo(type: "lang", top: "Test", middle: "Test", bottom: "Test", rating: 3.0)
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
                    companyName: "My Home"),
        SearchModel(appIcon: "https://i.pinimg.com/originals/27/bb/a2/27bba208a1f0a54544aed6a66e5e3331.png",
                    appTitle: "Sample",
                    summary: "Mock Data 용 Sample",
                    rating: 3.0,
                    info: [
                        AppInfo(type: "rating", top: "Test", middle: "Test", bottom: "Test", rating: 3.0),
                        AppInfo(type: "age", top: "Test", middle: "Test", bottom: "Test", rating: 3.0),
                        AppInfo(type: "chart", top: "Test", middle: "Test", bottom: "Test", rating: 3.0),
                        AppInfo(type: "dev", top: "Test", middle: "Test", bottom: "Test", rating: 3.0),
                        AppInfo(type: "lang", top: "Test", middle: "Test", bottom: "Test", rating: 3.0)
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
                    companyName: "My Home")
    ]
    
    func getData() -> [SearchModel] {
        return dummy_searchModel
    }
}
