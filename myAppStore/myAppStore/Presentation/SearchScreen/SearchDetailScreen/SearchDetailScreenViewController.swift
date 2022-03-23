//
//  SearchDetailScreenViewController.swift
//  myAppStore
//
//  Created by 김희수 on 2022/03/19.
//

import UIKit
import ReactiveSwift

protocol SearchDetailScreenViewControllerProtocol: AnyObject {
    func updateScreen()
}

final class SearchDetailScreenViewController: UIViewController {
    
    @IBOutlet weak var detailTable: UITableView!
    
    var presenter: SearchDetailScreenPresenterProtocol?
    
    private var cellFactory = SearchDetailScreenTableCellFactory()
    private var viewLayout: [String]?
    private var controllers: [CellController<UITableView>]?
    private var disposables = CompositeDisposable()
    
    override func viewDidLoad() {
        Log.Debug(.UI, "")
        super.viewDidLoad()
        presenter?.onViewDidLoad()
        configuration()
    }
    
    private func configuration() {
        detailTable.delegate = self
        detailTable.dataSource = self

        registerCell()
    }
    
    private func registerCell() {
        guard let layout = presenter?.getViewLayout() else {
            Log.Debug(.UI, "failed to get cell layout...")
            return
        }
        controllers = cellFactory.registerCells(delegate: self, tableView: detailTable, data: layout)
    }

}

extension SearchDetailScreenViewController: SearchDetailScreenViewControllerProtocol {
    
    func updateScreen() {
        DispatchQueue.main.async {
            self.detailTable.reloadData()
        }
    }
}

extension SearchDetailScreenViewController: UITableViewDelegate {
    
}

extension SearchDetailScreenViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let controllers = controllers else {
            Log.Debug(.UI, "no added controllers...")
            return 0
        }
        return controllers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let controllers = controllers else {
            Log.Debug(.UI, "no added controllers...")
            return UITableViewCell()
        }
        return controllers[indexPath.row].cellFromReusableCellHolder(tableView, data: presenter?.getCellData(), forIndexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let controllers = controllers else {
            Log.Debug(.UI, "no added controllers...")
            return 0.0
        }
        return controllers[indexPath.row].getCellHeight()
    }
    
}

extension SearchDetailScreenViewController: SearchDetailScreenDelegate {
    
    func updateTable() {
        DispatchQueue.main.async {
            self.detailTable.reloadData()
        }
    }
    
}
