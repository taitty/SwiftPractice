//
//  PopularTileCell.swift
//  myMovieGuide
//
//  Created by 김희수 on 2022/02/14.
//

import UIKit

class PopularTileCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var votingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
