//
//  TitleCellController.swift
//  myAppStore
//
//  Created by 김희수 on 2022/03/20.
//

import UIKit

class TitleCellController: GenericCellController<TitleCell> {
    
    override func configureCellContent(_ cell: TitleCell, data: SearchModel?) {
        if let imgUrl = URL(string: data?.appIcon ?? ""),
           let data = try? Data(contentsOf: imgUrl) {
            cell.appIcon.image = UIImage(data: data)
        }
        cell.appTitle.text = data?.appTitle
        cell.appCompany.text = data?.companyName
    }
    
    override func getCellHeight() -> CGFloat {
        return 110.0
    }
}

