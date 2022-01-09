//
//  TableCell.swift
//  myGenericViewFactory
//
//  Created by 김희수 on 2022/01/04.
//

import UIKit

class TableCell: UITableViewCell {

    @IBOutlet weak var tableView: UITableView!

    var viewData: [ViewDataModel] = []
    var cellController: [CellController<UITableView>] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension TableCell: UITableViewDelegate {
    
}

extension TableCell: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellController.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cellController[indexPath.row].cellFromReusableCellHolder(tableView, data: viewData[indexPath.row], forIndexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellController[indexPath.row].getCellHeight()
    }
    
}
