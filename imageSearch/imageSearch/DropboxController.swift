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
                     complection: @escaping (_ response: Files.FileMetadata?, _ error: CallError<Files.UploadError>?) -> Void) {
        let dropboxClient = DropboxClientsManager.authorizedClient
        dropboxClient?.files.upload(path: path, input: file).response(completionHandler: complection)
    }
    
    func getPreview(name: String,
                    complection: @escaping (_ response: Sharing.SharedLinkMetadata?, _ error: CallError<Sharing.CreateSharedLinkWithSettingsError>?) -> Void) {
        let linkSetting = Sharing.SharedLinkSettings(requestedVisibility: .public_)
        let dropboxClient = DropboxClientsManager.authorizedClient
        dropboxClient?.sharing.createSharedLinkWithSettings(path: name, settings: linkSetting).response(completionHandler: complection)
    }
    
    func deleteImage(name: String,
                     complection: @escaping (_ response: Files.DeleteResult?, _ error: CallError<Files.DeleteError>?) -> Void) {
        let dropboxClient = DropboxClientsManager.authorizedClient
        dropboxClient?.files.deleteV2(path: name).response(completionHandler: complection)
    }
    
}

