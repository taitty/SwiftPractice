//
//  webViewViewController.swift
//  webPlugin
//
//  Created by 김희수 on 2020/06/27.
//  Copyright © 2020 taitty. All rights reserved.
//

import UIKit
import WebKit

class webViewViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        webView.navigationDelegate = self
        webView.uiDelegate = self
        
        let url = Bundle.main.url(forResource: "test1", withExtension: "html", subdirectory: ".")
        if let url = url {
        webView.loadFileURL(url, allowingReadAccessTo: url)
        let request = URLRequest(url: url)
        webView.load(request)
        } else {
            print("no files.....")
        }
    }
    
}
