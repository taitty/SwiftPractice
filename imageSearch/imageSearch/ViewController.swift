//
//  ViewController.swift
//  imageSearch
//
//  Created by 김희수 on 13/09/2019.
//  Copyright © 2019 taitty. All rights reserved.
//

import UIKit
import SwiftyDropbox
import WebKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imgSource: UIImageView!
    @IBOutlet weak var resultWebview: WKWebView!
    
    let picker = UIImagePickerController()
    let cloudHandler = DropboxController()
    var resultTxt: String?
    var resultImg: String?
    var aToken: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        resultWebview.navigationDelegate = self
    }
    
    @IBAction func btnSearch(_ sender: UIButton) {
        
        /*
         1. connect dropbox
         2. take a photo
         3. upload photo to dropbox
         4. get public link
         5. go search to google image search
         6. get response with html
         7. parse name and photo
         */
        
        // 1. connect Dropbox --> from
        cloudHandler.connect(controller: self)
        // <-- to

        // 2. take a photo
        //self.takePhoto()
        
        // 3. upload photo to dropbox --> from
        /*
        let sourceFile = (imgResult.image?.jpegData(compressionQuality: 1.0))!
        let path = "/test2.jpg"
        
        cloudHandler.uploadImage(path: path, file: sourceFile) { response, error in
            if let error = error {
                print(error)
                return
            }
            
            print(response)

        }
        */
        // <-- to
        
        // 4. get public link
        //self.getPreview()
        
        // 5. go search to google image search
        
        
        // 6. get response with html
        
        
        
        // 7. parse name and photo

    }
    
    func takePhoto() {
        picker.sourceType = .camera
        present(picker, animated: false, completion: nil)
    }

    func goSearch(imgUrl : UIImage) {
      
        guard let url = URL(string:"http://images.google.com/searchbyimage?image_url=https://www.dropbox.com/s/b6o6piwu8jn589r/toyStory.jpg?raw=1") else {return}

        let request = URLRequest(url: url)
        resultWebview?.load(request)

    }
}

extension ViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imgSource.image = image
            goSearch(imgUrl: image)
        }
        dismiss(animated: true, completion: nil)
    }
}

extension UIViewController: WKNavigationDelegate {
        
    public func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("start loading")
    }
    
    public func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        print("start re-direction")
    }
    
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("finished loading")
        
        
        webView.evaluateJavaScript("document.body.innerHTML", completionHandler: { (value: Any!, error: Error!) -> Void in

            if error != nil {
                print(error)
                return
            }

            let result = value as? String
            //Main logic
            print(result)
        })
    }
}
