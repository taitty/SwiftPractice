//
//  FirstTableViewCell.swift
//  myTableViewFactory
//
//  Created by 김희수 on 2021/12/14.
//

import UIKit

class FirstTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var onoffSwifth: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension FirstTableViewCell: CustomTableViewCellProtocol {
    
    func registerCell(on tableView: UITableView) -> CustomTableViewCellProtocol {
        let secondNibName = UINib(nibName: "FirstTableViewCell", bundle: nil)
        tableView.register(secondNibName, forCellReuseIdentifier: "FirstTableViewCell")
        return self
    }
    
    func getCellForTableView(_ tableView: UITableView) -> CustomTableViewCellProtocol {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "FirstTableViewCell") as! SecondTableViewCell
        return cell
    }
    
    func didCellSelected(_ tableView: UITableView, indexPath: IndexPath) {
        
    }
    
    
}
