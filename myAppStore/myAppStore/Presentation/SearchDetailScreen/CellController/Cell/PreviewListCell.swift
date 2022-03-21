//
//  PreviewListCell.swift
//  myAppStore
//
//  Created by 김희수 on 2022/03/20.
//

import UIKit

class PreviewListCell: UICollectionViewCell {

    @IBOutlet weak var previewImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        previewImage.layer.cornerRadius = 10
    }

}
