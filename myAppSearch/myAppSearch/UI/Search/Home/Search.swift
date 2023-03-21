//
//  Search.swift
//  myAppSearch
//
//  Created by 김희수 on 2023/03/19.
//

import UIKit
import Combine

class Search: UIViewController {
    enum ViewType: Int {
        case SearchResult = 0
        case SearchKeyword = 1
        
        var id: String {
            switch self {
            case .SearchResult:
                return "SearchResult"
            case .SearchKeyword:
                return "SearchKeyword"
            }
        }
    }
    
    private var viewModel = SearchViewModel()
    private var cancellable = Set<AnyCancellable>()
    
    @IBOutlet weak var searchResultView: UITableView!
    @IBOutlet weak var searchKeywordView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Log.Debug(.UI, "")
        
        configuration()
        setupSearchBar()
        setObserver()
    }
    
    private func configuration() {
        searchResultView.delegate = self
        searchResultView.dataSource = self
        
        searchKeywordView.delegate = self
        searchKeywordView.dataSource = self
        
        registerCell()
    }
    
    private func registerCell() {
        let result = UINib(nibName: "SearchResult", bundle: nil)
        searchResultView.register(result, forCellReuseIdentifier: "SearchResult")
        
        let keyword = UINib(nibName: "SearchKeyword", bundle: nil)
        searchKeywordView.register(keyword, forCellReuseIdentifier: "SearchKeyword")
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
    
    private func setObserver() {
        viewModel.$viewData.sink(receiveValue: { data in
            Log.Debug(.UI, "\(data)")
            DispatchQueue.main.async {
                if data.isEmpty {
                    self.searchResultView.isHidden = true
                    self.searchKeywordView.isHidden = false
                    self.searchKeywordView.reloadData()
                } else {
                    self.searchResultView.isHidden = false
                    self.searchKeywordView.isHidden = true
                    self.searchResultView.reloadData()
                }
            }
        }).store(in: &cancellable)
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

extension Search: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Log.Debug(.UI, "\(tableView.tag)")
        Log.Debug(.UI, "\(indexPath.row)")
        
        if ViewType(rawValue: tableView.tag) == .SearchResult {
            let storyboard = UIStoryboard(name: "SearchDetail", bundle: Bundle.main)
            guard let controller = storyboard.instantiateViewController(withIdentifier: "SearchDetail") as? SearchDetail else {
                Log.Debug(.UI, "failed to get controller")
                return
            }
            controller.viewData = viewModel.baseData[indexPath.row]
            self.navigationController?.pushViewController(controller, animated: true)
        } else {
            Log.Debug(.UI, "")
        }
    }
}

extension Search: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Log.Debug(.UI, "\(tableView.tag)")
        return ViewType(rawValue: tableView.tag) == .SearchResult ? viewModel.viewData.count : 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        Log.Debug(.UI, "\(tableView.tag)")
        
        if ViewType(rawValue: tableView.tag) == .SearchResult {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResult", for: indexPath) as? SearchResult else {
                return UITableViewCell()
            }
            cell.setupCell(data: viewModel.viewData[indexPath.row])
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchKeyword", for: indexPath) as? SearchKeyword else {
                return UITableViewCell()
            }
            return cell
        }
    }
}
