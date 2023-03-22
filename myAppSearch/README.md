# Summary
- App Store 앱의 검색 탭 클론 코딩
- iTunes Search API 를 사용
https://affiliate.itunes.apple.com/resources/documentation/itunes-store-web-service-search-api/

# How to build
1. pod install
2. open *.xcworkspace

# Screenshot
추천 검색어|연관 검색어|검색 결과|세부 항목
---|---|---|---
![Simulator Screen Shot - iPhone 14 Pro - 2023-03-22 at 14 25 44](https://user-images.githubusercontent.com/30424849/226813615-cb02390e-4898-4e2a-8ec3-616482b15988.jpeg)|![Simulator Screen Shot - iPhone 14 Pro - 2023-03-22 at 14 25 55](https://user-images.githubusercontent.com/30424849/226813643-4bf32ff5-2b54-4a46-811c-1cc708c74737.jpeg)|![Simulator Screen Shot - iPhone 14 Pro - 2023-03-22 at 14 26 01](https://user-images.githubusercontent.com/30424849/226813670-4ece4d36-c1b8-4d5d-8459-0d31e0b722b0.jpeg)|![Simulator Screen Shot - iPhone 14 Pro - 2023-03-22 at 14 26 04](https://user-images.githubusercontent.com/30424849/226813716-f2cd91a7-14a0-42aa-a6ab-c5ef1e5bd597.jpeg)

# Demo
|![ezgif-3-00c2427ace](https://user-images.githubusercontent.com/30424849/226816045-edaac2d1-9201-42ac-b40f-8af29e636f3c.gif)|

# Environment
- Swift, Storyboard, Combine, Cosmos
- MVVM, Clean Architecture

# Dependency Injection
- Instance 생성 시, 사용해야할 Data Source Instance 를 주입
```Swift
    let dataSource = AppContext.real.dataSource
    let usecase = RequestSearchUsecase(dataSource: dataSource)
```

- 주입받은 Instance 는, 실제 Data 를 보유하고 있는 Repository(or Data Source) 로 사용
```Swift
    struct RequestSearchUsecase {
        private let dataSource: AppStoreRequirement

        init(dataSource: AppStoreRequirement) {
            self.dataSource = dataSource
        }

        func execute(keyword: String) -> AnyPublisher<[AppInfo], TraceError> {
            Log.Debug(.DOMAIN, "keyword : \(keyword)")
            return dataSource.requestSearch(keyword: keyword)
        }
    }
```

# Testable Code
### 테스트/실사용 목정에 따라, Context 를 구분하여 생성/전달
- Dependency Context 를 enum 으로 선언
```Swift
    enum AppContext {
        case test
        case real

        var dataSource: AppStoreRequirement {
            switch self {
            case .real:
                return AppStoreDataSource()
            case .test:
                return MockAppStoreDataSource()
            }
        }
    }
```

- 실사용 시,
```Swift
    let dataSource = AppContext.real.dataSource
    let usecase = RequestSearchUsecase(dataSource: dataSource)
```

- 테스트 시,
```Swift
    let dataSource = AppContext.test.dataSource
    let usecase = RequestSearchUsecase(dataSource: dataSource)
```

# Unit Test
- 주입되는 dataSource 에 따라, test/real 로 구분

> let usecase = RequestSearchUsecase(dataSource: AppContext.real.dataSource) 

- 혹은,

> let usecase = RequestSearchUsecase(dataSource: AppContext.test.dataSource) 

- Example
```Swift
    func testRequestSearchUsecaseFailCaseWithMock() throws {
        let promise = expectation(description: "test fail case with mock")
        var cancellable = Set<AnyCancellable>()
        
        let useCase = RequestSearchUsecase(dataSource: AppContext.test.dataSource)
        useCase.execute(keyword: "오류").sink(receiveCompletion: { result in
            switch result {
            case .finished:
                XCTAssert(false, "success")
            case .failure(let error):
                promise.fulfill()
                XCTAssert(true, "\(error)")
            }
        }, receiveValue: { data in
            XCTAssert(data.isEmpty)
        })
        .store(in: &cancellable)
        
        wait(for: [promise], timeout: 5)
    }
```
