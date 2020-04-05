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
import SwiftSoup
import SDWebImage

enum Mode {
    case OFF
    case ON
}

class ViewController: UIViewController {
    
    @IBOutlet weak var imgSource: UIImageView!
    @IBOutlet weak var resultString: UILabel!
    @IBOutlet weak var resultImages: UICollectionView!
    @IBOutlet weak var resultImagesBorder: UIView!
    @IBOutlet weak var resultImagesPlaceholder: UILabel!
    @IBOutlet weak var loadingImage: UIActivityIndicatorView!
    
    let searchWebview = WKWebView()
    let picker = UIImagePickerController()
    let cloudHandler = DropboxController()
    
    var photoUrl: String?
    var photoPath: String?
    var searchResult: String?
    var searchImageUrls: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self
        searchWebview.navigationDelegate = self
        resultImages.dataSource = self
        
        controlGuideText(mode: .ON)
        controlLoadingView(mode: .OFF)
        setBasicTemplate()
        
        NotificationCenter.default.addObserver(self, selector: #selector(uploadPhoto(notification:)), name: Notification.Name("dropbox_connect"), object: nil)
    }
    
    func setBasicTemplate() {
        
        imgSource.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0).cgColor
        imgSource.layer.borderWidth = 1.0
        imgSource.layer.cornerRadius = imgSource.layer.frame.size.height / 15.0
        imgSource.layer.masksToBounds = true

        resultImagesBorder.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0).cgColor
        resultImagesBorder.layer.borderWidth = 1.0
        resultImagesBorder.layer.cornerRadius = imgSource.layer.frame.size.height / 15.0
        resultImagesBorder.layer.masksToBounds = true
        
    }
    
    @IBAction func btnSearch(_ sender: UIButton) {
        if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        present(picker, animated: false, completion: nil)
    }
    
    func parseHtml() {
        do {
            let doc: Document = try SwiftSoup.parse(searchResult!)
            
            // parse result text
            let resultText = try doc.getElementsByClass("r5a77d").text() // 검색결과를 Text 로 가지고 있는 Class : r5a77d
            print(resultText)
            resultString.text = resultText
            
            // parse search images and titles
            let imgs = try doc.select("img")
            for element: Element in imgs.array() {
                if let url = try? element.attr("src"), url.hasPrefix("https://encrypted") {
                    print(url)
                    self.searchImageUrls.append(url)
                }
            }

            controlLoadingView(mode: .OFF)
            DispatchQueue.main.async {
                self.resultImages.reloadData()
            }
            
        } catch Exception.Error(let type, let message) {
            print("error type [\(type)], message [\(message)]")
        } catch {
            print("what???")
        }
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
        
        guard let userInfo = notification.userInfo, userInfo["connect"] as? String == "true" else {
            print("failed to connect cloud")
            return
        }
        
        guard let sourceFile = imgSource.image?.jpegData(compressionQuality: 0.3) else {
            print("no photo")
            return
        }
        
        let timestamp = NSDate().timeIntervalSince1970
        self.photoPath = "/\(timestamp)+test.jpg"
        
        print("start uploading photo")
        
        guard let path = self.photoPath else {
            print("fail to get photoPath")
            return
        }
        
        controlGuideText(mode: .OFF)
        controlLoadingView(mode: .ON)

        cloudHandler.uploadImage(path: path, file: sourceFile) { response, error in
            if let error = error {
                print(error)
                return
            }
            print("success upload photo")
            
            self.getPhotoUrl(name: path)
        }
    }
    
    func controlGuideText(mode: Mode) {
        if mode == .ON {
            self.resultImagesPlaceholder.isHidden = false
        } else {
            self.resultImagesPlaceholder.isHidden = true
        }
    }
    
    func controlLoadingView(mode: Mode) {
        if mode == .ON {
            loadingImage.isHidden = false
            loadingImage.startAnimating()
        } else {
            loadingImage.stopAnimating()
            loadingImage.isHidden = true
        }
    }
    
    func deletePhoto() {
        
        guard let name = photoPath else {
            print("no photo to delete")
            return
        }
        
        cloudHandler.deleteImage(name: name) { response, error in
            if let error = error {
                print(error)
                return
            }
            
            print("success delete image")
        }
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
        searchWebview.load(request)
    }
}

extension ViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imgSource.image = image
        }
        dismiss(animated: true, completion: nil)
        self.connectCloud()
    }
}

extension ViewController: WKNavigationDelegate {
        
//    public func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
//        print("start loading")
//    }
//    
//    public func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
//        print("start re-direction")
//    }
//    
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("finished loading")

        webView.evaluateJavaScript("document.body.innerHTML") { value, error in

            if error != nil {
                print(error as Any)
                return
            }

            self.searchResult = value as? String
            self.deletePhoto()
            self.parseHtml()
        }
    }
}

extension ViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.searchImageUrls.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchResultCell", for: indexPath) as! searchResultCell
        cell.searchImage.sd_setImage(with: URL(string: self.searchImageUrls[indexPath.row]), completed: nil)
        return cell
    }

}
