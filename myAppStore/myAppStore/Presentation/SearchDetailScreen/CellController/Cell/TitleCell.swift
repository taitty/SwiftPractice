//
//  TitleCell.swift
//  myAppStore
//
//  Created by 김희수 on 2022/03/20.
//

import UIKit

class TitleCell: UITableViewCell {

    @IBOutlet weak var appIcon: UIImageView!
    @IBOutlet weak var appTitle: UILabel!
    @IBOutlet weak var appCompany: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        appIcon.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
