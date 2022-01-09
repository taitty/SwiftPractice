//
//  CollectionButtonCellController.swift
//  myGenericViewFactory
//
//  Created by 김희수 on 2022/01/04.
//

import Foundation
import UIKit

class CollectionButtonCellController: GenericCellController<CollectionButtonCell> {
    
    override func configureCellContent(_ cell: CollectionButtonCell, data: ViewDataModel) {
        cell.buttonLabel.titleLabel?.text = data.title
    }
    
    override func didSelectCell() {
        
    }

}
