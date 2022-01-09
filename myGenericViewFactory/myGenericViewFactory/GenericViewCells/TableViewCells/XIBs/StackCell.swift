//
//  StackCell.swift
//  myGenericViewFactory
//
//  Created by 김희수 on 2022/01/05.
//

import UIKit

class StackCell: UITableViewCell {

    @IBOutlet weak var stackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
