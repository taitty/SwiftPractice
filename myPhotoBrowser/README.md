# Summary
- Unsplash 앱 Clone Coding Test
- 진입 시에는 Editorial Contents, Search 수행 시에는 결과 Contents 들이 보여짐
- Combine 을 사용한 Reactive Programming 도전


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
<img src="https://github.com/taitty/SwiftPractice/blob/master/myPhotoBrowser/Note/Presentation.svg" width="800px">

### Control Flow
<img src="https://github.com/taitty/SwiftPractice/blob/master/myPhotoBrowser/Note/Layout.svg" width="800px">


# Dependency Injection
#### Screen 이동 시, 해당 Screen 에서 사용해야할 Data Source Instance 를 주입
    let dataSource = ServerContext.real.dataSource
    let wireframe = BrowseScreenWireframe(dataSource: dataSource)

#### 주입받은 Instance 는, 해당 Screen 의 각 Controller 에서 사용하도록 재주입
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


# Testable Code
### 테스트/실사용 목정에 따라, Context 를 구분하여 생성/전달
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

#### 실사용 시,
    let dataSource = ServerContext.real.dataSource
    let wireframe = BrowseScreenWireframe(dataSource: dataSource)

#### 테스트 시,
    let dataSource = ServerContext.mock.dataSource
    let wireframe = BrowseScreenWireframe(dataSource: dataSource)


# Data Flow
