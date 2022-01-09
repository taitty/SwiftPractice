//
//  CollectionLabelCellController.swift
//  myGenericViewFactory
//
//  Created by 김희수 on 2022/01/04.
//

import Foundation
import UIKit

class CollectionLabelCellController: GenericCellController<CollectionLabelCell> {
    
    override func configureCellContent(_ cell: CollectionLabelCell, data: ViewDataModel) {
        cell.titleLabel.text = data.title
    }
    
    override func didSelectCell() {
        
    }

}
