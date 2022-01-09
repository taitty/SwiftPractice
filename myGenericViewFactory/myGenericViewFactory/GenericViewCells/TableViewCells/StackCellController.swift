//
//  StackCellController.swift
//  myGenericViewFactory
//
//  Created by 김희수 on 2022/01/05.
//

import Foundation
import UIKit

let STACKCELL_HEIGHT = 50.0

class StackCellController: GenericCellController<StackCell> {
    
    override func configureCellContent(_ cell: StackCell, data: ViewDataModel) {
        for (idx, item) in data.item.enumerated() {
            let frame = CGRect(x: 100.0*CGFloat(idx), y: 0.0, width: 100.0, height: STACKCELL_HEIGHT)
            let subView = StackButtonCell(frame: frame)
            subView.cellLabel.text = item.title
            cell.stackView.addArrangedSubview(subView)
        }
    }
    
    override func getCellHeight() -> CGFloat {
        return STACKCELL_HEIGHT
    }
}
