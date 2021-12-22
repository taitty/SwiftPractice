//
//  LabelCell.swift
//  myTableViewFactory
//
//  Created by 김희수 on 2021/12/22.
//

import UIKit

class LabelCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension LabelCell: TableViewCellProtocol {
    
    func registerCell(tableView: UITableView) {
        let nibName = UINib(nibName: "LabelCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "LabelCell")
    }
    
    func getCellForRow(tableView: UITableView, data: TableViewDataModel) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell") as! LabelCell
        cell.titleLabel.text = data.title
        return cell
    }
    
    func didCellSelected() {
        
    }
    
    func getCellHeight() -> CGFloat {
        return 50.0
    }
    
}
