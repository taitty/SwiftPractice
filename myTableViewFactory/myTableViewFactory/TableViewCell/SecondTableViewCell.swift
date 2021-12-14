//
//  SecondTableViewCell.swift
//  myTableViewFactory
//
//  Created by 김희수 on 2021/12/14.
//

import UIKit

class SecondTableViewCell: UITableViewCell {

    @IBOutlet weak var onoffButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension SecondTableViewCell: CustomTableViewCellProtocol {
    
    func registerCell(on tableView: UITableView) -> CustomTableViewCellProtocol {
        let secondNibName = UINib(nibName: "SecondTableViewCell", bundle: nil)
        tableView.register(secondNibName, forCellReuseIdentifier: "SecondTableViewCell")
        return self
    }
    
    func getCellForTableView(_ tableView: UITableView) -> CustomTableViewCellProtocol {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "SecondTableViewCell") as! SecondTableViewCell
        return cell
    }
    
    func didCellSelected(_ tableView: UITableView, indexPath: IndexPath) {
        
    }
    
}
