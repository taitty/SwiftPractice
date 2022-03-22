//
//  GameTabViewController.swift
//  myAppStore
//
//  Created by 김희수 on 2022/03/19.
//

import UIKit

class GameTabViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Log.Debug(.UI, "")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let storyboard = UIStoryboard(name: "GameScreen", bundle: Bundle.main)
        let view = storyboard.instantiateViewController(withIdentifier: "GameScreen")
        self.navigationController?.pushViewController(view, animated: true)
    }
    
}
