//
//  SearchResultCell.swift
//  myAppStore
//
//  Created by 김희수 on 2022/03/19.
//

import UIKit
import Cosmos

class SearchResultCell: UITableViewCell {

    @IBOutlet weak var appIconImage: UIImageView!
    @IBOutlet weak var appTitle: UILabel!
    @IBOutlet weak var appDescription: UILabel!
    @IBOutlet weak var appRatingStar: CosmosView!
    @IBOutlet weak var appRating: UILabel!
    @IBOutlet weak var openButton: UIButton!
    @IBOutlet weak var thumbnail_1st: UIImageView!
    @IBOutlet weak var thumbnail_2nd: UIImageView!
    @IBOutlet weak var thumbnail_3rd: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
