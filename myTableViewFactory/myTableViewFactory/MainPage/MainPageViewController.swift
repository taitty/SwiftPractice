//
//  MainPageViewController.swift
//  myTableViewFactory
//
//  Created by 김희수 on 2022/03/25.
//

import UIKit

struct CellData {
    var type: String
    var firstString: String
    var secondString: String
    var imgPath: String
}

class MainPageViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var cellFactory: CellFactoryProtocol?
    var cellControllers: [GenericCellController]?
    
    let viewData: [CellData] = [
        CellData(type: "labelCell", firstString: "text1", secondString: "text2", imgPath: ""),
        CellData(type: "labelCell", firstString: "string1", secondString: "string2", imgPath: ""),
        CellData(type: "imageCell", firstString: "", secondString: "", imgPath: "home/test.jpg"),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        cellFactory?.registerCell(on: tableView)
    }
    
}

extension MainPageViewController: UITableViewDelegate {}

extension MainPageViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cellFactory?.configurationCell(on: tableView, data: viewData[indexPath.row], indexPath: indexPath) ?? UITableViewCell()
    }
    
}
