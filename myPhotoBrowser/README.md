# Summary
- Unsplash 앱 Clone Coding
- Editorial Contents 와 Search Result Contents 가, 하나의 View 를 사용
- Keyword 검색 여부에 따라, 화면이 구성됨


# Screenshot
|Home Screen|Detail Screen|Info Screen|
|---|---|---|
|![Simulator Screen Shot - iPhone 11 - 2022-04-02 at 21 54 13](https://user-images.githubusercontent.com/30424849/161385197-48752c27-4182-44e9-a71f-b92000ff1190.png)|![Simulator Screen Shot - iPhone 11 - 2022-04-02 at 22 21 17](https://user-images.githubusercontent.com/30424849/161385235-37f7f7c0-f084-416a-838d-74e1cab6b569.png)|![Simulator Screen Shot - iPhone 11 - 2022-04-02 at 22 21 22](https://user-images.githubusercontent.com/30424849/161385242-0062e3cd-30fa-4527-bf60-c5360f369c65.png)|


# Demo
|Browsing|Searching|
|---|---|
|![Simulator Screen Recording - iPhone 11 - 2022-04-02 at 22 26 59](https://user-images.githubusercontent.com/30424849/161385476-2437d274-c2cf-4837-9015-fb13a4bfa176.gif)|![Simulator Screen Recording - iPhone 11 - 2022-04-02 at 22 29 17](https://user-images.githubusercontent.com/30424849/161385540-a60e8994-e0b3-4b36-96e8-2f02810ec379.gif)|


# Environment
- Swift, Storyboard, Combine
- VIPER, Clean Architecture


# Layout

### Presentation
- VIPER Pattern 적용
- Combine 을 사용하여 Class 간의 Signal 전달
<img src="https://github.com/taitty/SwiftPractice/blob/master/myPhotoBrowser/Note/Presentation.svg" width="800px">

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

## Unit Test
- 주입되는 dataSource 에 따라, Mock/Real 구분하여 진행

> let useCase = GetHomeDataUseCase(dataSource: `MockUnsplashDataSource()`, dataMode: .initialData) 
>> 혹은,
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
