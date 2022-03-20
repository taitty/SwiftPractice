//
//  HistoryCell.swift
//  myAppStore
//
//  Created by 김희수 on 2022/03/20.
//

import UIKit

class HistoryCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var version: UILabel!
    @IBOutlet weak var updateTime: UILabel!
    @IBOutlet weak var history: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
