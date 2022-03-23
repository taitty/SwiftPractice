//
//  MainViewController.swift
//  myAppStore
//
//  Created by 김희수 on 2022/03/19.
//

import UIKit

enum TabBarConfig: CaseIterable {
    case today
    case game
    case apps
    case update
    case search
    
    var controller: UIViewController {
        switch self {
        case .today:
            return TodayScreenWireframe().create()
        case .game:
            return GameScreenWireframe().create()
        case .apps:
            return AppScreenWireframe().create()
        case .update:
            return UpdateScreenWireframe().create()
        case .search:
            let dataSource = SearchScreenContext.real.dataSource
            return SearchResultScreenWireframe(dataSource: dataSource).create()
        }
    }
    
    var icon: String {
        switch self {
        case .today:
            return "doc.text.image"
        case .game:
            return "gamecontroller.fill"
        case .apps:
            return "square.stack.3d.up.fill"
        case .update:
            return "square.and.arrow.down.fill"
        case .search:
            return "magnifyingglass"
        }
    }
    
    var title: String {
        switch self {
        case .today:
            return "투데이"
        case .game:
            return "게임"
        case .apps:
            return "앱"
        case .update:
            return "업데이트"
        case .search:
            return "검색"
        }
    }
}

class MainViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Log.Debug(.UI, "")
        
        let controllers: [UIViewController] = TabBarConfig.allCases.map {
            let controller = $0.controller
            controller.tabBarItem = UITabBarItem(title: $0.title, image: UIImage(systemName: $0.icon), selectedImage: UIImage(systemName: $0.icon))
            return controller
        }
        setViewControllers(controllers, animated: true)
        configuration()
    }
    
    private func configuration() {
        selectedIndex = 4
    }
}
