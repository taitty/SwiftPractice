//
//  ImageCell.swift
//  myTableViewFactory
//
//  Created by 김희수 on 2022/03/25.
//

import UIKit

class ImageCell: UITableViewCell {

    @IBOutlet weak var previewView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
