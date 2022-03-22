//
//  HistoryCell.swift
//  myAppStore
//
//  Created by 김희수 on 2022/03/20.
//

import UIKit
import ReactiveSwift

class HistoryCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var version: UILabel!
    @IBOutlet weak var updateTime: UILabel!
    @IBOutlet weak var history: UITextView!
    @IBOutlet weak var moreButton: UIButton!
    
    let expandedHeight = MutableProperty(0.0)

    override func awakeFromNib() {
        super.awakeFromNib()
        moreButton.isHidden = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func pressMore(_ sender: Any) {
        moreButton.isHidden = true
        history.sizeToFit()
        let viewSize = history.intrinsicContentSize
        let curWidth = viewSize.width
        let curHeight = viewSize.height
        let preHeight = history.superview?.frame.height
        if let preHeight = preHeight, curHeight > preHeight {
            expandedHeight.value = curHeight - preHeight
            frame.size = CGSize(width: curWidth, height: curHeight)
        }
    }
}
