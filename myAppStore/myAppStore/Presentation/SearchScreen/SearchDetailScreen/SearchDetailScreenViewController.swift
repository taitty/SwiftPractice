//
//  SearchDetailScreenViewController.swift
//  myAppStore
//
//  Created by 김희수 on 2022/03/19.
//

import UIKit
import ReactiveSwift

class SearchDetailScreenViewController: UIViewController {
    
    @IBOutlet weak var detailTable: UITableView!
    
    private var viewModel: SearchDetailScreenViewModel?
    private var cellFactory = SearchDetailScreenTableCellFactory()
    private var viewLayout: [String]?
    private var controllers: [CellController<UITableView>]?
    private var disposables = CompositeDisposable()
    
    override func viewDidLoad() {
        Log.Debug(.UI, "")
        super.viewDidLoad()
        viewModel?.onViewDidLoad()
        configuration()
    }
    
    private func configuration() {
        detailTable.delegate = self
        detailTable.dataSource = self

        registerCell()
        setupObserver()
    }
    
    private func registerCell() {
        if let layout = viewLayout {
            controllers = cellFactory.registerCells(delegate: self, tableView: detailTable, data: layout)
        }
    }
    
    private func setupObserver() {
        disposables += viewModel?.viewData.producer.skip(while: { $0 == nil }).startWithValues { _ in
            DispatchQueue.main.async {
                self.detailTable.reloadData()
            }
        }
    }
}

extension SearchDetailScreenViewController: UITableViewDelegate {
    
}

extension SearchDetailScreenViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controllers?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel, let controllers = controllers else {
            return UITableViewCell()
        }
        return controllers[indexPath.row].cellFromReusableCellHolder(tableView, data: viewModel.viewData.value, forIndexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let controllers = controllers else {
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
