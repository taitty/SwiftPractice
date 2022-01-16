//
//  ViewController.swift
//  myTableViewCell
//
//  Created by 김희수 on 2022/01/16.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tableViewCell = TableViewCellWireframe()
        let destination = tableViewCell.setup()
        destination.modalPresentationStyle = .fullScreen
        DispatchQueue.main.async {
            self.present(destination, animated: true)
        }
    }

}

