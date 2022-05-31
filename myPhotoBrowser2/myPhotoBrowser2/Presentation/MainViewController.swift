//
//  MainViewController.swift
//  myPhotoBrowser
//
//  Created by 김희수 on 2022/03/30.
//

import UIKit

final class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configuration()
    }

    override func viewDidAppear(_ animated: Bool) {
        let dataSource = ServerContext.real.dataSource
        let wireframe = BrowseScreenWireframe(dataSource: dataSource)
        let view = wireframe.setup()
        view.modalPresentationStyle = .fullScreen
        self.present(view, animated: false, completion: nil)
    }
    
    private func configuration() {
        self.view.backgroundColor = .systemBackground
    }
}
