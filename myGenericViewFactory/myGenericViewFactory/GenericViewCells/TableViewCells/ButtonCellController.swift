//
//  ButtonCellController.swift
//  myGenericViewFactory
//
//  Created by 김희수 on 2022/01/04.
//

import Foundation
import UIKit

class ButtonCellController: GenericCellController<ButtonCell> {
    
    override func configureCellContent(_ cell: ButtonCell, data: ViewDataModel) {
        cell.buttonLabel.titleLabel?.text = data.title
    }
    
    override func didSelectCell() {
        
    }
    
    override func getCellHeight() -> CGFloat {
        return 40.0
    }
}
