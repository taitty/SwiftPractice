//
//  HomeScreenViewController.swift
//  myMovieGuide
//
//  Created 김희수 on 2022/01/26.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import ReactiveSwift

protocol HomeScreenViewProtocol: AnyObject {
    func updateScreen(data: [HomeScreenCategory])
}

final class HomeScreenViewController: UIViewController {
    var presenter: HomeScreenPresenterProtocol!
    let cellFactory = SectionCategoryFactory()

    @IBOutlet weak var homeTableView: UITableView!
    
    private var disposables = CompositeDisposable()
    private var homeScreenViewData: [HomeScreenCategory] = [] {
        didSet {
            DispatchQueue.main.async {
                self.homeTableView.reloadData()
            }
        }
    }
    
    private var eventHandler: HomeScreenCellDelegate? {
        guard let handler = try? DIContainer.resolve(HomeScreenCellDelegate.self) else {
            Log.Debug(.UI, "HomeScreenCellDelegate is not registered")
            return nil
        }
        return handler
    }
    
    deinit{
        disposables.dispose()
        Log.Debug(.UI, "")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configuration()
        presenter.onViewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func configuration() {
        homeTableView.delegate = self
        homeTableView.dataSource = self
        
        MovieGuideCategory.allCases.forEach { item in
            cellFactory.registerCells(on: homeTableView, type: item)
        }
        
        disposables += eventHandler?.selectedContentTileCell.producer.startWithValues { result, data in
            if result {
                Log.Debug(.UI, "\(String(describing: data))")
                self.presenter.touchedCell(data: data)
            }
        }
    }
    
}

// MARK: - ViewProtocol
extension HomeScreenViewController: HomeScreenViewProtocol {
    
    func updateScreen(data: [HomeScreenCategory]) {
        homeScreenViewData = data;
        Log.Debug(.UI, "viewData is updated")
    }
    
}

extension HomeScreenViewController: UITableViewDelegate {}

extension HomeScreenViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeScreenViewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cellFactory.configurationCell(on: tableView, viewData: homeScreenViewData[indexPath.row], indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let type = MovieGuideCategory(rawValue: indexPath.row) else {
            Log.Debug(.UI, "category is invalid")
            return 0.0
        }
        return cellFactory.getHeight(type: type)
    }
    
}
