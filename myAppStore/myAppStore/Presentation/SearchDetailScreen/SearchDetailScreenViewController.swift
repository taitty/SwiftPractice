//
//  SearchDetailScreenViewController.swift
//  myAppStore
//
//  Created by 김희수 on 2022/03/19.
//

import UIKit

class SearchDetailScreenViewController: UIViewController {
    
    var presenter: SearchDetailScreenPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Log.Debug(.UI, "")
        
        configuration()
        presenter?.onViewDidLoad()
    }
    
    private func configuration() {

    }
}