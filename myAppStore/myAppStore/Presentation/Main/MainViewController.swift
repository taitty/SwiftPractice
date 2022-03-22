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
            return TodayTabViewController()
        case .game:
            return GameTabViewController()
        case .apps:
            return AppsTabViewController()
        case .update:
            return UpdateTabViewController()
        case .search:
            return SearchTabViewController()
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
            controller.tabBarItem = UITabBarItem(title: $0.title, image: UIImage(named: $0.icon), selectedImage: UIImage(named: $0.icon))
            return controller
        }
        let tabControllers: [UINavigationController] = controllers.map {
            UINavigationController(rootViewController: $0)
        }
        setViewControllers(tabControllers, animated: true)
        configuration()
    }
    
    private func configuration() {
//        tabBar.backgroundColor = .gray
        selectedIndex = 4
    }
}
