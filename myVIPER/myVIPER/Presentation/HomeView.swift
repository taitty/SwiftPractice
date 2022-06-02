//
//  HomeView.swift
//  myVIPER
//
//  Created by 김희수 on 2022/05/31.
//

import UIKit

class HomeView: UIViewController {
    
    let presenter: HomePresenter
    
    init?(coder: NSCoder, presenter: HomePresenter) {
        NSLog("HomeView")
        self.presenter = presenter
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
}
