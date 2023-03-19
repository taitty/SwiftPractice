//
//  Search.swift
//  myAppSearch
//
//  Created by 김희수 on 2023/03/19.
//

import UIKit

class Search: UIViewController {
    private var viewModel = SearchViewModel()
    @IBOutlet weak var contentView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Log.Debug(.UI, "")
        
        setupSearchBar()
    }
    
    private func setupSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "게임, 앱, 스토리 등"
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.title = "검색"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
}

extension Search: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        Log.Debug(.UI, searchBar.text ?? "")
        if let text = searchBar.text {
            viewModel.requestSearch(keyword: text)
        }
    }
}
