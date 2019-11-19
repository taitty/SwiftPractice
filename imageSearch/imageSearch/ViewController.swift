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
    var photoUrl: String?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        resultWebview.navigationDelegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(uploadPhoto(notification:)), name: Notification.Name("dropbox_connect"), object: nil)
    }
    
    @IBAction func btnSearch(_ sender: UIButton) {
        
        /*
         2. take a photo
         3. upload photo to dropbox
         4. get public link
         5. go search to google image search
         6. get response with html
         7. parse name and photo
         */

        // 2. take a photo
        takePhoto()
        
        // 3. upload photo to dropbox
        //uploadPhoto()
        
        // 4. get public link
        //getPhotoUrl()
        
        // 5. go search to google image search
        //goSearch()
        
        // 6. get response with html
        
        
        
        // 7. parse name and photo

    }
    
    func getPhotoUrl (name: String) {
        
        print("start to get url of photo")
        
        cloudHandler.getPreview(name: name) { response, error in
            if let error = error {
                print(error)
                return
            }

            print("success to get url")
            
            if let rsp = response {
                let url = rsp.url
                let urlSeparator = url.firstIndex(of: "?") ?? url.endIndex
                let publicUrl = url[..<urlSeparator]

                self.photoUrl = String(publicUrl+"?raw=1")
                
                print("publicUrl = \(String(describing: self.photoUrl))")
                
                if let requestUrl = self.photoUrl {
                    print(requestUrl)
                    self.goSearch(photoUrl: requestUrl)
                } else {
                    print("fail to get final url")
                    return
                }
            }
        }
    }
    
    func connectCloud() {
        print("start to check connection")
        cloudHandler.connect(controller: self)
    }
    
    @objc func uploadPhoto(notification: Notification) {
        
        guard let sourceFile = imgSource.image?.jpegData(compressionQuality: 0.3) else {
            print("no photo")
            return
        }

        let timestamp = NSDate().timeIntervalSince1970
        let path = "/\(timestamp)+test.jpg"
        
        print("start uploading photo")

        cloudHandler.uploadImage(path: path, file: sourceFile) { response, error in
            if let error = error {
                print(error)
                return
            }
            print("success upload photo")
            
            self.getPhotoUrl(name: path)
        }
    }
    
    func takePhoto() {
        if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        present(picker, animated: false, completion: nil)
    }

    func goSearch(photoUrl : String) {
      
        let baseUrl = "http://images.google.com/searchbyimage?image_url="
        let searchUrl = baseUrl+photoUrl
        guard let url = URL(string: searchUrl) else {
            print("fail to get searchUrl")
            return
        }

        print(url)
        
        let request = URLRequest(url: url)
        resultWebview?.load(request)
    }
}

extension ViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imgSource.image = image
        }
        dismiss(animated: true, completion: nil)
        self.connectCloud()
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
