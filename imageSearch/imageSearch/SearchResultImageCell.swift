//
//  SearchResultImageCell.swift
//  imageSearch
//
//  Created by 김희수 on 2019/12/02.
//  Copyright © 2019 taitty. All rights reserved.
//

import Foundation
import UIKit

class searchResultCell: UICollectionViewCell {
    
    @IBOutlet weak var searchImage: UIImageView!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {

        self.layoutIfNeeded()
        
        searchImage.layer.cornerRadius = searchImage.layer.frame.size.height / 15.0
        searchImage.layer.masksToBounds = true
        
    }
}
