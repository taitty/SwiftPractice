//
//  MainTitleCell.swift
//  socialPlatform
//
//  Created by 김희수 on 2022/01/11.
//

import UIKit

class MainTitleCell: GeneralCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func configureCell(data: ViewDataModel) {
        super.configureCell(data: data)

        titleLabel.text = data.text
    }
    
}
