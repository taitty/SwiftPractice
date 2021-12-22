//
//  SubTableCell.swift
//  myTableViewFactory
//
//  Created by 김희수 on 2021/12/22.
//

import UIKit

class SubTableCell: UITableViewCell {

    @IBOutlet weak var tableView: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tableView.delegate = self
        tableView.dataSource = self

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension SubTableCell: TableViewCellProtocol {
    
    func registerCell(tableView: UITableView) {
        let nibName = UINib(nibName: "SubTableCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "SubTableCell")
    }
    
    func getCellForRow(tableView: UITableView, data: TableViewDataModel) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubTableCell") as! SubTableCell
        return cell
    }
    
    func didCellSelected() {
        
    }
    
    func getCellHeight() -> CGFloat {
        return 200.0
    }
    
}

extension SubTableCell: UITableViewDelegate {
    
}

extension SubTableCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
