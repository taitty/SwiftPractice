//
//  MainPageViewController.swift
//  myViperApp
//
//  Created by 김희수 on 2021/11/05.
//

import UIKit

protocol MainPageViewControllerProtocol: AnyObject {
    
}

class MainPageViewController: UIViewController {
    
    var presenter: MainPagePresenterProtocol?
    
    @IBOutlet var buttons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MainPageRouter.createMainPage(from: self)
        
        presenter?.viewDidLoad()
    }
    
    @IBAction func clickButton(_ sender: UIButton) {
        
        print("request to change page to \(String(describing: PageType(rawValue: sender.tag)?.description()))")
        
        guard let pageType = PageType(rawValue: sender.tag) else {
            print("requested wrong page")
            return
        }
        
        let ret = presenter?.requestToChangePage(from: self, to: pageType)
        
        if let ret = ret, ret != .error_none {
            print(ret.description())
        }
    }
    
    private func setUp() {
        
    }
    
}

extension MainPageViewController: MainPageViewControllerProtocol {
    
}
