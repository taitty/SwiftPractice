//
//  RootViewController.swift
//  myTableViewFactory
//
//  Created by 김희수 on 2022/03/26.
//

import UIKit

class RootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        let storyboard = UIStoryboard(name: "MainPage", bundle: Bundle.main)
        let view = storyboard.instantiateViewController(withIdentifier: "MainPage") as! MainPageViewController
        view.cellFactory = CellFactory()
        let nav = UINavigationController(rootViewController: view)
        self.present(nav, animated: true, completion: nil)
    }
}
