//
//  Main.swift
//  myAppSearch
//
//  Created by 김희수 on 2023/03/19.
//

import UIKit

enum TabBarConfig: String, CaseIterable {
    case Today
    case Game
    case App
    case Arcade
    case Search
    
    var icon: String {
        switch self {
        case .Today:
            return "doc.text.image"
        case .Game:
            return "gamecontroller.fill"
        case .App:
            return "square.stack.3d.up.fill"
        case .Arcade:
            return "mappin.and.ellipse"
        case .Search:
            return "magnifyingglass"
        }
    }
    
    var title: String {
        switch self {
        case .Today:
            return "투데이"
        case .Game:
            return "게임"
        case .App:
            return "앱"
        case .Arcade:
            return "아케이드"
        case .Search:
            return "검색"
        }
    }
    
    var controller: UIViewController {
        let storyboard = UIStoryboard(name: self.rawValue, bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: self.rawValue)
        return UINavigationController(rootViewController: vc)
    }
    
}

class MainVC: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        Log.Debug(.UI, "")
        
        let controllers: [UIViewController] = TabBarConfig.allCases.compactMap {
            let controller = $0.controller
            controller.tabBarItem = UITabBarItem(title: $0.title, image: UIImage(systemName: $0.icon), selectedImage: UIImage(systemName: $0.icon))
            return controller
        }
        setViewControllers(controllers, animated: true)
        
        tabBar.backgroundColor = .systemGray6
        selectedIndex = 4
    }
}
