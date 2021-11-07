//
//  FirstPageViewController.swift
//  myViperApp
//
//  Created by 김희수 on 2021/11/08.
//

import Foundation
import UIKit

protocol FirstPageViewControllerProtocol: AnyObject {
    var presenter: FirstPagePresenterProtocol? { get set }
}

class FirstPageViewController: UIViewController {
    var presenter: FirstPagePresenterProtocol?
    
    override func viewDidLoad() {
        print("First Page is launched")
    }
}

extension FirstPageViewController: FirstPageViewControllerProtocol {
    
}
