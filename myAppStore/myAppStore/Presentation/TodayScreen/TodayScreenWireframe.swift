//
//  TodayScreenWireframe.swift
//  myAppStore
//
//  Created by 김희수 on 2022/03/19.
//

import UIKit

class TodayScreenWireframe {
    
    func create() -> UIViewController {
        let storyboard = UIStoryboard(name: "TodayScreen", bundle: Bundle.main)
        let view = storyboard.instantiateViewController(withIdentifier: "TodayScreen")
        return UINavigationController(rootViewController: view)
    }
    
}
