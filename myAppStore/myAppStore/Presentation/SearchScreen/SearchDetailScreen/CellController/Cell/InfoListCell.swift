//
//  InfoListCell.swift
//  myAppStore
//
//  Created by 김희수 on 2022/03/20.
//

import UIKit
import Cosmos

class InfoListCell: UICollectionViewCell {

    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var middleLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var starRating: CosmosView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
