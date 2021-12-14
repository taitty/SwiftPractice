//
//  ViewController.swift
//  myTableViewFactory
//
//  Created by 김희수 on 2021/12/14.
//

import UIKit

class ViewController: UIViewController {
    
    let data = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    var cellFactory: TableViewCellFactory?

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
     
        cellFactory = TableViewCellFactory(tableView: tableView)
    }

}

extension ViewController: UITableViewDelegate {
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let order = indexPath.row % 2
        switch order {
        case 0:
            let cell = cellFactory?.getCellForTableView(cellType: .FirstCellType)
            cell.titleLabel.text = data[indexPath.row]
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SecondTableViewCell") as! SecondTableViewCell
            cell.resultLabel.text = data[indexPath.row]
            return cell
        }
    }
    
}
