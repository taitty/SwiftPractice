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
        SearchModel(appIcon: "https://i.pinimg.com/originals/27/bb/a2/27bba208a1f0a54544aed6a66e5e3331.png",
                    appTitle: "Sample",
                    summary: "Mock Data 용 Sample",
                    rating: 3.5,
                    preview: [
                        "https://i.pinimg.com/736x/18/d0/b2/18d0b2f08e4a20ec0c6d67c57ff8e37c.jpg",
                        "https://i.pinimg.com/736x/18/d0/b2/18d0b2f08e4a20ec0c6d67c57ff8e37c.jpg",
                        "https://i.pinimg.com/736x/18/d0/b2/18d0b2f08e4a20ec0c6d67c57ff8e37c.jpg"
                    ]),
        SearchModel(appIcon: "https://i.pinimg.com/originals/27/bb/a2/27bba208a1f0a54544aed6a66e5e3331.png",
                    appTitle: "Sample",
                    summary: "Mock Data 용 Sample",
                    rating: 3.5,
                    preview: [
                        "https://i.pinimg.com/736x/18/d0/b2/18d0b2f08e4a20ec0c6d67c57ff8e37c.jpg",
                        "https://i.pinimg.com/736x/18/d0/b2/18d0b2f08e4a20ec0c6d67c57ff8e37c.jpg",
                        "https://i.pinimg.com/736x/18/d0/b2/18d0b2f08e4a20ec0c6d67c57ff8e37c.jpg"
                    ]),
        SearchModel(appIcon: "https://i.pinimg.com/originals/27/bb/a2/27bba208a1f0a54544aed6a66e5e3331.png",
                    appTitle: "Sample",
                    summary: "Mock Data 용 Sample",
                    rating: 3.5,
                    preview: [
                        "https://i.pinimg.com/736x/18/d0/b2/18d0b2f08e4a20ec0c6d67c57ff8e37c.jpg",
                        "https://i.pinimg.com/736x/18/d0/b2/18d0b2f08e4a20ec0c6d67c57ff8e37c.jpg",
                        "https://i.pinimg.com/736x/18/d0/b2/18d0b2f08e4a20ec0c6d67c57ff8e37c.jpg"
                    ]),
        SearchModel(appIcon: "https://i.pinimg.com/originals/27/bb/a2/27bba208a1f0a54544aed6a66e5e3331.png",
                    appTitle: "Sample",
                    summary: "Mock Data 용 Sample",
                    rating: 3.5,
                    preview: [
                        "https://i.pinimg.com/736x/18/d0/b2/18d0b2f08e4a20ec0c6d67c57ff8e37c.jpg",
                        "https://i.pinimg.com/736x/18/d0/b2/18d0b2f08e4a20ec0c6d67c57ff8e37c.jpg",
                        "https://i.pinimg.com/736x/18/d0/b2/18d0b2f08e4a20ec0c6d67c57ff8e37c.jpg"
                    ]),
        SearchModel(appIcon: "https://i.pinimg.com/originals/27/bb/a2/27bba208a1f0a54544aed6a66e5e3331.png",
                    appTitle: "Sample",
                    summary: "Mock Data 용 Sample",
                    rating: 3.5,
                    preview: [
                        "https://i.pinimg.com/736x/18/d0/b2/18d0b2f08e4a20ec0c6d67c57ff8e37c.jpg",
                        "https://i.pinimg.com/736x/18/d0/b2/18d0b2f08e4a20ec0c6d67c57ff8e37c.jpg",
                        "https://i.pinimg.com/736x/18/d0/b2/18d0b2f08e4a20ec0c6d67c57ff8e37c.jpg"
                    ]),
        SearchModel(appIcon: "https://i.pinimg.com/originals/27/bb/a2/27bba208a1f0a54544aed6a66e5e3331.png",
                    appTitle: "Sample",
                    summary: "Mock Data 용 Sample",
                    rating: 3.5,
                    preview: [
                        "https://i.pinimg.com/736x/18/d0/b2/18d0b2f08e4a20ec0c6d67c57ff8e37c.jpg",
                        "https://i.pinimg.com/736x/18/d0/b2/18d0b2f08e4a20ec0c6d67c57ff8e37c.jpg",
                        "https://i.pinimg.com/736x/18/d0/b2/18d0b2f08e4a20ec0c6d67c57ff8e37c.jpg"
                    ]),
    ]
    
    func getData() -> [SearchModel] {
        return dummy_searchModel
    }
}
