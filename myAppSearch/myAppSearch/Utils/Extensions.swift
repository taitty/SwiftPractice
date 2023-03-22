//
//  Extensions.swift
//  myAppSearch
//
//  Created by 김희수 on 2023/03/21.
//

import UIKit

extension String {
    var isNotEmpty: Bool {
        return !self.isEmpty
    }
}

extension Array {
    var isNotEmpty: Bool {
        return !self.isEmpty
    }
}

let imageCache = NSCache<AnyObject, AnyObject>()
extension UIImageView {
    func getImage(urlString: String) {
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        self.image = UIImage(named: "questionmark")
        self.contentMode = .scaleAspectFit
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
