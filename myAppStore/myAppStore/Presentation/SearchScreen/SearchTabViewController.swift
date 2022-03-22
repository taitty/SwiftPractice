//
//  SearchTabViewController.swift
//  myAppStore
//
//  Created by 김희수 on 2022/03/23.
//

import UIKit

class SearchTabViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Log.Debug(.UI, "")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let storyboard = UIStoryboard(name: "SearchResultScreen", bundle: Bundle.main)
        let view = storyboard.instantiateViewController(withIdentifier: "SearchResultScreen")
        self.navigationController?.pushViewController(view, animated: true)
        
    }
}
