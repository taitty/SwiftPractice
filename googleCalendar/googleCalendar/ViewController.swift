//
//  ViewController.swift
//  googleCalendar
//
//  Created by 김희수 on 2020/04/07.
//  Copyright © 2020 taitty. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var handler: GoogleSignInController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        handler = GoogleSignInController(viewController: self)

    }

    @IBAction func btnSignIn(_ sender: UIButton) {
        handler?.doSignIn()
    }
    
    @IBAction func btnSignOut(_ sender: UIButton) {
        handler?.doSignOut()
    }
    
    
}

