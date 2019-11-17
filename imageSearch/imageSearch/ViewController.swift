//
//  ViewController.swift
//  imageSearch
//
//  Created by 김희수 on 13/09/2019.
//  Copyright © 2019 taitty. All rights reserved.
//

import UIKit
import SwiftyDropbox
import GoogleSignIn
import WebKit

class ViewController: UIViewController {

//    enum cloud {
//        case dropbox
//        case google
//
//
//    }
    
    @IBOutlet weak var txtResult: UITextView!
    @IBOutlet weak var imgSource: UIImageView!
    @IBOutlet weak var imgResult: UIImageView!
    @IBOutlet weak var resultWebview: WKWebView!
    
    let picker = UIImagePickerController()
    let cloudHandler = DropboxController()
    var resultTxt: String?
    var resultImg: String?
    var aToken: String = ""
    let scopes = ["https://www.googleapis.com/auth/photoslibrary.readonly"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        resultWebview.navigationDelegate = self
        
        GIDSignIn.sharedInstance()?.clientID = "912444868039-p5v00ctocl881beipdl58e4p33ik17pq.apps.googleusercontent.com"
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance().scopes = scopes
        
        GIDSignIn.sharedInstance()?.presentingViewController = self

        // Automatically sign in the user.
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()

        // ...
    }
    
    @IBAction func btnConnect(_ sender: Any) {
        //cloudHandler.connect(controller: self)
        self.signIn()
    }
    
    @IBAction func btnUpload(_ sender: Any) {
        
        let sourceFile = (imgResult.image?.jpegData(compressionQuality: 1.0))!
        let path = "/test2.jpg"
        
        cloudHandler.uploadImage(path: path, file: sourceFile) { response, error in
            if let error = error {
                print(error)
                return
            }
            
            print(response)
            self.getPreview()
        }
        
    }
    
    @IBAction func btnCapture(_ sender: UIButton) {
        picker.sourceType = .camera
        present(picker, animated: false, completion: nil)
    }
    
    @IBAction func btnSearch(_ sender: UIButton) {
        self.openLibrary()
                
        //self.goSearch(imgUrl: "abc")
        
        
        
    }
    
    func openLibrary(){
        picker.sourceType = .photoLibrary
        present(picker, animated: false, completion: nil)
    }

    func uiUpdate() {
        DispatchQueue.main.async {
            self.txtResult.text = self.resultTxt
        }
        
        let url = URL(string: self.resultImg!)
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { data, response, error -> Void in
            guard let data = data, error == nil else {
                print(error)
                return
            }
            
            DispatchQueue.main.async() {
                self.imgResult.image = UIImage(data: data)
            }
        }
        task.resume()
    }
    
    func getPreview() {
        let dropboxClient = DropboxClientsManager.authorizedClient
        dropboxClient?.sharing.getFileMetadata(file: "/test2.jpg").response { response, error in
            if let error = error {
                print(error)
                return
            }
            
            print(response)
            
        }
    }

}

extension ViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    func goSearch(imgUrl : String) {

        let KEY = "AIzaSyC7ZTOJzoLKkU3H-8HsNVNiIawtIHfQ3Uc"
        let CX = "002545689968007474890:lpvju1cnznj"
        let SEARCH = "image"
        //let QR = "https://drive.google.com/uc?export=view&id=1DGMt45fjL3EUT9GNNGnrhqdT68w_gyfq"
        let QR = "https://dl.dropboxusercontent.com/s/b6o6piwu8jn589r/toyStory.jpg"
        let request = URLRequest(url: URL(string: "https://www.googleapis.com/customsearch/v1?key=\(KEY)&cx=\(CX)&searchType=\(SEARCH)&q=\(QR)")!)
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error -> Void in
            do {
                let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                let items = json["items"] as? [Dictionary<String, Any>]

                for item in items! {
                    self.resultTxt = item["title"] as? String
                    self.resultImg = item["link"] as? String
                    break
                }
                self.uiUpdate()
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    func goSearch(imgUrl : UIImage) {
      
        guard let url = URL(string:"http://images.google.com/searchbyimage?image_url=https://www.dropbox.com/s/b6o6piwu8jn589r/toyStory.jpg?raw=1") else {return}

        let request = URLRequest(url: url)
        resultWebview?.load(request)

    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imgSource.image = image
            goSearch(imgUrl: image)
        }
        dismiss(animated: true, completion: nil)
    }
}

extension ViewController : GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                print("The user has not signed in before or they have since signed out.")
            } else {
                print("\(error.localizedDescription)")
            }
            return
        }
        // Perform any operations on signed in user here.
        let userId = user.userID                  // For client-side use only!
        let idToken = user.authentication.idToken // Safe to send to the server
        let fullName = user.profile.name
        let givenName = user.profile.givenName
        let familyName = user.profile.familyName
        let email = user.profile.email
        aToken = user.authentication.accessToken

        // ...
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
      // Perform any operations when the user disconnects from app here.
      // ...
    }
    
    func signIn() {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    func didTapSignOut() {
      GIDSignIn.sharedInstance().signOut()
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
