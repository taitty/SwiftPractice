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
    @IBOutlet weak var rating: UILabel!
    @IBOutlet var preview: [UIImageView]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
