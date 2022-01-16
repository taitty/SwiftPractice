//
//  ButtonCell.swift
//  socialPlatform
//
//  Created by 김희수 on 2022/01/11.
//

import UIKit

class ButtonCell: GeneralCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    let STACKCELL_HEIGHT = 50.0
    var viewData: ViewDataModel?
    
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

        guard let _ = viewData else {
            viewData = data
            titleLabel.text = data.text
            for (idx, item) in data.item.enumerated() {
                let frame = CGRect(x: 100.0 * CGFloat(idx), y: 0.0, width: 100.0, height: STACKCELL_HEIGHT)
                let subView = StackButtonCell(frame: frame)
                subView.titleLabel.text = item.text
                subView.cellID = idx
                stackView.addArrangedSubview(subView)
            }
            return
        }
    }
    
}
