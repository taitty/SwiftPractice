//
//  ButtonCell.swift
//  myTableViewFactory
//
//  Created by 김희수 on 2021/12/22.
//

import UIKit

class ButtonCell: UITableViewCell {

    @IBOutlet weak var buttonTitle: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension ButtonCell: TableViewCellProtocol {
    
    func registerCell(tableView: UITableView) {
        let nibName = UINib(nibName: "ButtonCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "ButtonCell")
    }
    
    func getCellForRow(tableView: UITableView, data: TableViewDataModel) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ButtonCell") as! ButtonCell
        cell.buttonTitle.titleLabel?.text = data.title
        return cell
    }
    
    func didCellSelected() {
        
    }
    
    func getCellHeight() -> CGFloat {
        return 80.0
    }
    
}
