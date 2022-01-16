//
//  DescriptionCell.swift
//  socialPlatform
//
//  Created by 김희수 on 2022/01/11.
//

import UIKit

class DescriptionCell: GeneralCell {

    @IBOutlet weak var descriptionLabel: UILabel!
    
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

        descriptionLabel.text = data.text
    }
    
}
