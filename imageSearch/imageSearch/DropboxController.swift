//
//  Dropbox.swift
//  imageSearch
//
//  Created by 김희수 on 2019/10/12.
//  Copyright © 2019 taitty. All rights reserved.
//

import Foundation
import SwiftyDropbox

class DropboxController {
    
    func connect(controller: UIViewController) {
        DropboxClientsManager.authorizeFromController(UIApplication.shared,
                                                      controller: controller,
                                                      openURL: { (url: URL) -> Void in
                                                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                                      })
    }
    
    func uploadImage(path: String,
                     file: Data,
                     complection: @escaping (_ result: Files.FileMetadata?, _ error: CallError<Files.UploadError>?) -> Void) {
        let dropboxClient = DropboxClientsManager.authorizedClient
        dropboxClient?.files.upload(path: path, input: file).response(completionHandler: complection)
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
