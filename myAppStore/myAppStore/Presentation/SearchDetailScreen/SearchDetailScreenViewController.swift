//
//  SearchDetailScreenViewController.swift
//  myAppStore
//
//  Created by 김희수 on 2022/03/19.
//

import UIKit

class SearchDetailScreenViewController: UIViewController {
    
    var viewModel: SearchDetailScreenViewModelProtocol?
    
    override func viewDidLoad() {
        Log.Debug(.UI, "")
        super.viewDidLoad()
        
        configuration()
        viewModel?.onViewDidLoad()
    }
    
    private func configuration() {
        viewModel = SearchDetailScreenViewModel()
    }
}
