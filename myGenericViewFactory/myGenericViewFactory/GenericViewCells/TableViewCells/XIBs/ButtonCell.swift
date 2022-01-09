//
//  ButtonCell.swift
//  myGenericViewFactory
//
//  Created by 김희수 on 2022/01/04.
//

import UIKit

class ButtonCell: UITableViewCell {

    @IBOutlet weak var buttonLabel: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
