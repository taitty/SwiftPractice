//
//  ImageCollectionCell.swift
//  myAppStore
//
//  Created by 김희수 on 2022/03/20.
//

import UIKit

class ImageCollectionCell: UITableViewCell {

    @IBOutlet weak var imageCollection: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
