//
//  ViewController.swift
//  imageSearch
//
//  Created by 김희수 on 13/09/2019.
//  Copyright © 2019 taitty. All rights reserved.
//

import UIKit
import SwiftyDropbox

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
    
    let picker = UIImagePickerController()
    let cloudHandler = DropboxController()
    var resultTxt: String?
    var resultImg: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
    }
    
    @IBAction func btnConnect(_ sender: Any) {
        cloudHandler.connect(controller: self)
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
    
    func goSearch(imgUrl : UIImage) {

        let KEY = "AIzaSyC7ZTOJzoLKkU3H-8HsNVNiIawtIHfQ3Uc"
        let CX = "002545689968007474890:lpvju1cnznj"
        let SEARCH = "image"
        let QR = "https://pds.joins.com/news/component/htmlphoto_mmdata/201505/23/htm_20150523095940741.jpg"
        
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imgSource.image = image
            goSearch(imgUrl: image)
        }
        dismiss(animated: true, completion: nil)
    }
}

