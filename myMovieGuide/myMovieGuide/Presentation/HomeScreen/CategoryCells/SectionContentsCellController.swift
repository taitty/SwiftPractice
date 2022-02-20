//
//  SectionContentsCellController.swift
//  myMovieGuide
//
//  Created by 김희수 on 2022/02/14.
//

import UIKit

class SectionContentsCellController: GenericCellController<UITableView, UITableViewCell, CGFloat> {
    
    override var identifier: String {
        return String(describing: type(of: self)).components(separatedBy: "Controller").joined()
    }
    
    override func registerCell(on: PARAM) {
        let contentsNib = UINib(nibName: identifier, bundle: nil)
        on.register(contentsNib, forCellReuseIdentifier: identifier)
    }
    
    override func configurationCell(on: PARAM, indexPath: IndexPath) -> VALUE {
        let cell = on.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        //TODO: need to implement cell configuration
        return cell
    }
    
    override func getHeight() -> SIZE {
        return 160.0
    }
    
}
