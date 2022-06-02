//
//  MainViewController.swift
//  myVIPER
//
//  Created by 김희수 on 2022/05/31.
//

import UIKit
import os

class MainViewController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        let data = "Test"
        let wireframe = HomeWireframe(data: data)
        let view = wireframe.setup()
        self.present(view, animated: true)
    }
}
