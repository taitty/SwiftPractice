//
//  ImageCellController.swift
//  myTableViewFactory
//
//  Created by 김희수 on 2022/03/26.
//

import Foundation
import UIKit

class ImageCellController: GenericCellController {
    
    override class var cellClass: AnyClass {
        return self
    }
    
    override func configurationCell(on: UITableView, data: CellData, indexPath: IndexPath) -> UITableViewCell {
        let cell = on.dequeueReusableCell(withIdentifier: "ImageCell", for: indexPath) as! ImageCell
        cell.previewView.image = UIImage(systemName: data.imgPath)
        return cell
    }
    
    override func getHeightForCell() -> CGFloat {
        return 160.0
    }
}

