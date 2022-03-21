//
//  SearchResultCell.swift
//  myAppStore
//
//  Created by 김희수 on 2022/03/19.
//

import UIKit
import Cosmos

class SearchResultCell: UICollectionViewCell {

    @IBOutlet weak var appIcon: UIImageView!
    @IBOutlet weak var appTitle: UILabel!
    @IBOutlet weak var appSummary: UILabel!
    @IBOutlet weak var ratingStar: CosmosView!
    @IBOutlet var thumbnail: [UIImageView]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configuration()
    }
    
    private func configuration() {
        ratingStar.settings.updateOnTouch = false
        ratingStar.settings.starSize = 15
        ratingStar.settings.starMargin = 1
        ratingStar.settings.filledColor = .gray
        ratingStar.settings.emptyBorderColor = .gray
        ratingStar.settings.filledBorderColor = .gray
        
        appIcon.layer.cornerRadius = 10
        for i in 0...2 {
            thumbnail[i].layer.cornerRadius = 10
        }
    }

}
