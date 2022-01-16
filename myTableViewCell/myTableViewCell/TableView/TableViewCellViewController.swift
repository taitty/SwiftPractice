//
//  TableViewCellViewController.swift
//  socialPlatform
//
//  Created by 김희수 on 2022/01/06.
//

import UIKit

protocol TableViewCellViewProtocol {
    func updateTableViewData(data: [ViewDataModel]?)
}

final class TableViewCellViewController: UIViewController {

    var presenter: TableViewCellPresenterProtocol?
    var viewData: [ViewDataModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        titleLabel.text = "TableViewCell"
        
        registerCells()
        presenter?.onViewDidLoad()
    }
    
    private func registerCells() {
        let cellType = [
            "BlankCell",
            "ButtonCell",
            "SliderCell",
            "MainTitleCell",
            "DescriptionCell"
        ]
        
        cellType.forEach { cell in
            let nibName = UINib(nibName: cell, bundle: nil)
            tableView.register(nibName, forCellReuseIdentifier: cell)
        }
    }

}

extension TableViewCellViewController: TableViewCellViewProtocol {
    func updateTableViewData(data: [ViewDataModel]?) {
        if let newData = data {
            self.viewData = newData
        }
    }
}

extension TableViewCellViewController: UITableViewDelegate {
    
}

extension TableViewCellViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellData = viewData[indexPath.row]
        guard let cellType = TableViewCellTypes(rawValue: cellData.type),
              let cell = tableView.dequeueReusableCell(withIdentifier: cellType.cellId, for: indexPath) as? GeneralCell else {
                  return BlankCell()
              }
        cell.configureCell(data: cellData)
        return cell
    }
    
}

enum TableViewCellTypes: String, CaseIterable {
    case blankType
    case buttonType
    case sliderType
    case mainTitleType
    case descriptionType

    var cellId: String {
        switch self {
        case .blankType:
            return "BlankCell"
        case .buttonType:
            return "ButtonCell"
        case .sliderType:
            return "SliderCell"
        case .mainTitleType:
            return "MainTitleCell"
        case .descriptionType:
            return "DescriptionCell"
        }
    }
}

class GeneralCell: UITableViewCell {

    private func disableSelectEffect() {
        let background = UIView()
        background.backgroundColor = .clear
        self.selectedBackgroundView = background
    }

    func configureCell(data: ViewDataModel) {
        disableSelectEffect()
    }
}
