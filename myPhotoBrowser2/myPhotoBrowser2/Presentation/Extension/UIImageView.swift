//
//  UIImageView.swift
//  myPhotoBrowser
//
//  Created by 김희수 on 2022/04/04.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func getImage(urlString: String) {
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        self.image = UIImage(named: "Icon")
        self.contentMode = .scaleToFill
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!) { data, _, _ in
            if let response = data {
                DispatchQueue.main.async {
                    if let imageToCache = UIImage(data: response) {
                        imageCache.setObject(imageToCache, forKey: urlString as AnyObject)
                        self.image = imageToCache
                        self.contentMode = .scaleAspectFit
                    } else {
                        Log.Debug(.UI, "failed to get image with url")
                    }
                }
            }
        }.resume()
    }
    
}
