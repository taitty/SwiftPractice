//
//  HomeScreenViewController.swift
//  myMovieGuide
//
//  Created 김희수 on 2022/01/26.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol HomeScreenViewProtocol: AnyObject {}

enum HomeCategoryType: Int, CaseIterable {
    case Popular
    case OnNow
    case UpComing
}

final class HomeScreenViewController: UIViewController {
    var presenter: HomeScreenPresenterProtocol!
    let cellFactory = SectionCategoryFactory()

    @IBOutlet weak var homeTableView: UITableView!
    
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
        
        HomeCategoryType.allCases.forEach { item in
            cellFactory.registerCells(on: homeTableView, type: item)
        }
    }
    
}

// MARK: - ViewProtocol
extension HomeScreenViewController: HomeScreenViewProtocol {}

extension HomeScreenViewController: UITableViewDelegate {}

extension HomeScreenViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HomeCategoryType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let type = HomeCategoryType(rawValue: indexPath.row) else {
            Log.Debug(.UI, "category is invalid")
            return UITableViewCell()
        }
        return cellFactory.configurationCell(on: tableView, type: type, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let type = HomeCategoryType(rawValue: indexPath.row) else {
            Log.Debug(.UI, "category is invalid")
            return 0.0
        }
        return cellFactory.getHeight(type: type)
    }
    
}
