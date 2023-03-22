# Summary
- App Store 앱의 검색 탭 클론 코딩
- iTunes Search API 를 사용
https://affiliate.itunes.apple.com/resources/documentation/itunes-store-web-service-search-api/

# how to build
1. pod install
2. open *.xcworkspace

# Screenshot
Home Screen|Detail Screen|Info Screen
추천 검색어|연관 검색어|검색 결과|세부 항목
![Simulator Screen Shot - iPhone 14 Pro - 2023-03-22 at 14 25 44](https://user-images.githubusercontent.com/30424849/226813615-cb02390e-4898-4e2a-8ec3-616482b15988.jpeg)|![Simulator Screen Shot - iPhone 14 Pro - 2023-03-22 at 14 25 55](https://user-images.githubusercontent.com/30424849/226813643-4bf32ff5-2b54-4a46-811c-1cc708c74737.jpeg)|![Simulator Screen Shot - iPhone 14 Pro - 2023-03-22 at 14 26 01](https://user-images.githubusercontent.com/30424849/226813670-4ece4d36-c1b8-4d5d-8459-0d31e0b722b0.jpeg)|![Simulator Screen Shot - iPhone 14 Pro - 2023-03-22 at 14 26 04](https://user-images.githubusercontent.com/30424849/226813716-f2cd91a7-14a0-42aa-a6ab-c5ef1e5bd597.jpeg)

# Demo
|https://user-images.githubusercontent.com/30424849/226812174-cc364726-43aa-46e7-bb28-305b5ea338b0.mov|

# Environment
- Swift, Storyboard, Combine, Cosmos
- MVVM, Clean Architecture


# Layout

### Control Flow
- Data 는, Entity 에 정의된 Data Structure 에 따라, Data -> Domain -> Presentation Layer 방향으로 이동
- Data Source 는 Repository 에 정의된 Protocol 을 채택하여 구현
- 각 Screen 의 Interactor 는, UseCase 를 통해 필요한 Data 를 요청
<img src="https://github.com/taitty/SwiftPractice/blob/master/myPhotoBrowser/Note/Layout.svg" width="800px">

### Data Transfer
- BrowseScreen 과 DetailScreen 은 Delegate 를 통해 Data 를 전달
<img src="https://github.com/taitty/SwiftPractice/blob/master/myPhotoBrowser/Note/Delegate.svg" width="350px">


# Dependency Injection
- Screen 이동 시, 해당 Screen 에서 사용해야할 Data Source Instance 를 주입
```Swift
    let dataSource = ServerContext.real.dataSource
    let wireframe = BrowseScreenWireframe(dataSource: dataSource)
```

- 주입받은 Instance 는, 해당 Screen 의 각 Controller 에서 사용하도록 재주입
```Swift
    func setup() -> UIViewController {
        let storyboard = UIStoryboard(name: "BrowseScreen", bundle: Bundle.main)
        let view = storyboard.instantiateViewController(withIdentifier: "BrowseScreen") as? BrowseScreenViewController
        let presenter = BrowseScreenPresenter()
        let interactor = BrowseScreenInteractor()
        
        self.view = view
        view?.presenter = presenter
        presenter.interactor = interactor
        presenter.wireframe = self
        interactor.dataSource = dataSource
        
        guard let view = view else {
            Log.Debug(.UI, "failed to setup BrowseScreen...")
            return UIViewController()
        }
        return view
    }
```

# Testable Code
### 테스트/실사용 목정에 따라, Context 를 구분하여 생성/전달
- Dependency Context 를 enum 으로 선언
```Swift
    enum ServerContext {
        case real
        case mock

        var dataSource: UnsplashDataSourceProtocol {
            switch self {
            case .real:
                return UnsplashDataSource()
            case .mock:
                return MockUnsplashDataSource()
            }
        }
    }
```

- 실사용 시,
```Swift
    let dataSource = ServerContext.real.dataSource
    let wireframe = BrowseScreenWireframe(dataSource: dataSource)
```

- 테스트 시,
```Swift
    let dataSource = ServerContext.mock.dataSource
    let wireframe = BrowseScreenWireframe(dataSource: dataSource)
```

# Unit Test
- 주입되는 dataSource 에 따라, Mock/Real 구분하여 진행

> let useCase = GetHomeDataUseCase(dataSource: `MockUnsplashDataSource()`, dataMode: .initialData) 

- 혹은,

> let useCase = GetHomeDataUseCase(dataSource: `UnsplashDataSource()`, dataMode: .initialData)

- Example
```Swift
    func testGetHomeDataUseCaseFromMock() throws {
        let promise = expectation(description: "get HomeData from Mock")
        var cancellable = Set<AnyCancellable>()

        let useCase = GetHomeDataUseCase(dataSource: _UnsplashDataSource()_, dataMode: .initialData)
        useCase.sink(receiveCompletion: { result in
            switch result {
            case .finished:
                Log.Debug(.UNTEST, "done to get homeData...")
            case .failure(let error):
                XCTFail(error.message)
            }
        }, receiveValue: { value in
            promise.fulfill()
            XCTAssertTrue(!value.isEmpty)
        }).store(in: &cancellable)

        wait(for: [promise], timeout: 5)
    }
```
