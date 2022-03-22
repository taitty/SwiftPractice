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
    
    private var viewModel = SearchDetailScreenViewModel()
    private var cellFactory = SearchDetailScreenTableCellFactory()
    private var viewLayout: [String] = []
    private var controllers: [CellController<UITableView>] = []
    private var disposables = CompositeDisposable()
    
    weak var delegate: SearchScreenDelegate?
    
    override func viewDidLoad() {
        Log.Debug(.UI, "")
        super.viewDidLoad()
        viewModel.onViewDidLoad(item: delegate?.getSelectedItem())
        configuration()
    }
    
    private func configuration() {
        detailTable.delegate = self
        detailTable.dataSource = self
        viewLayout = viewModel.getViewLayout()
        registerCell()
        setupObserver()
    }
    
    private func registerCell() {
        controllers = cellFactory.registerCells(delegate: self, tableView: detailTable, data: viewLayout)
    }
    
    private func setupObserver() {
        disposables += viewModel.viewData.producer.skip(while: { $0 == nil }).startWithValues { _ in
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
        return controllers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return controllers[indexPath.row].cellFromReusableCellHolder(tableView, data: viewModel.viewData.value, forIndexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
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
