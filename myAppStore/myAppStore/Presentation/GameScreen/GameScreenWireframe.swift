//
//  GameScreenWireframe.swift
//  myAppStore
//
//  Created by 김희수 on 2022/03/19.
//

import UIKit

class GameScreenWireframe {

    func create() -> UIViewController {
        let storyboard = UIStoryboard(name: "GameScreen", bundle: Bundle.main)
        let view = storyboard.instantiateViewController(withIdentifier: "GameScreen")
        return UINavigationController(rootViewController: view)
    }
    
}
