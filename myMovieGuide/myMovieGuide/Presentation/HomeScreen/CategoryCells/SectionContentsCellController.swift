//
//  SectionContentsCellController.swift
//  myMovieGuide
//
//  Created by 김희수 on 2022/02/14.
//

import UIKit

//class SectionContentsCellController: GenericCellController<UITableView, UITableViewCell, CGFloat> {
class SectionContentsCellController {
    
    var identifier: String {
        return String(describing: type(of: self)).components(separatedBy: "Controller").joined()
    }
    
    func registerCell(on: UITableView) {
        let contentsNib = UINib(nibName: identifier, bundle: nil)
        on.register(contentsNib, forCellReuseIdentifier: identifier)
    }
    
    func configurationCell(on: UITableView, data: HomeScreenCategory) -> UITableViewCell {
        let cell = on.dequeueReusableCell(withIdentifier: identifier) as! SectionContentsCell
        cell.type = data.type
        cell.titleLabel.text = data.title
        cell.sectionData = data.contents ?? []
        return cell
    }
    
    func getHeight() -> CGFloat {
        return 160.0
    }
    
}
