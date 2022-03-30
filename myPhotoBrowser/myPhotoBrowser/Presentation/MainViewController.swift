//
//  ViewController.swift
//  myPhotoBrowser
//
//  Created by 김희수 on 2022/03/30.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configuration()
    }

    override func viewDidAppear(_ animated: Bool) {
        let dataSource = ServerContext.mock.dataSource
        let wireframe = BrowseScreenWireframe(dataSource: dataSource)
        let view = wireframe.setup()
        let nav = UINavigationController(rootViewController: view)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: false, completion: nil)
    }
    
    private func configuration() {
        self.view.backgroundColor = .systemBackground
    }
}
