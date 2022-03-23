//
//  UpdateScreenWireframe.swift
//  myAppStore
//
//  Created by 김희수 on 2022/03/19.
//

import UIKit

class UpdateScreenWireframe {
    
    func create() -> UIViewController {
        let storyboard = UIStoryboard(name: "UpdateScreen", bundle: Bundle.main)
        let view = storyboard.instantiateViewController(withIdentifier: "UpdateScreen")
        return UINavigationController(rootViewController: view)
    }
    
}
