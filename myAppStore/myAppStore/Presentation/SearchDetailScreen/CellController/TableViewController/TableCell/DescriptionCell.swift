//
//  DescriptionCell.swift
//  myAppStore
//
//  Created by 김희수 on 2022/03/20.
//

import UIKit

class DescriptionCell: UITableViewCell {

    @IBOutlet weak var summary: UITextView!
    @IBOutlet weak var developer: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
