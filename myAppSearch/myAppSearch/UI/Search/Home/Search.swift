//
//  Search.swift
//  myAppSearch
//
//  Created by 김희수 on 2023/03/19.
//

import UIKit
import Combine

protocol SearchScreenRequirement {
    func configCell()
}

class Search: UIViewController {
    enum ScreenType: Int {
        case SearchResultType = 0
        case SearchKeywordType = 1
        case RecentKeywordType = 2
        
        var id: String {
            switch self {
            case .SearchResultType:
                return "SearchResult"
            case .SearchKeywordType:
                return "SearchKeyword"
            case .RecentKeywordType:
                return "RecentKeyword"
            }
        }
    }
    
    enum ScreenStatus {
        case ready
        case editKeyword
        case startSearch
    }
    
    private var viewModel = SearchViewModel()
    private var cancellable = Set<AnyCancellable>()
    
    @IBOutlet weak var searchResultView: UITableView!
    @IBOutlet weak var searchKeywordView: UITableView!
    @IBOutlet weak var recentKeywordView: UITableView!
    
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
        
        recentKeywordView.delegate = self
        recentKeywordView.dataSource = self
        
        registerCell()
    }
    
    private func registerCell() {
        let result = UINib(nibName: "SearchResult", bundle: nil)
        searchResultView.register(result, forCellReuseIdentifier: "SearchResult")
        
        let keyword = UINib(nibName: "SearchKeyword", bundle: nil)
        searchKeywordView.register(keyword, forCellReuseIdentifier: "SearchKeyword")
        
        let recent = UINib(nibName: "RecentKeyword", bundle: nil)
        recentKeywordView.register(recent, forCellReuseIdentifier: "RecentKeyword")
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
                self.updateScreen(status: data.isEmpty ? .ready : .startSearch)
            }
        }).store(in: &cancellable)
        
        viewModel.$matchKeyword.sink(receiveValue: { data in
            DispatchQueue.main.async {
                self.searchKeywordView.reloadData()
            }
        }).store(in: &cancellable)
    }
    
    private func updateScreen(status: ScreenStatus) {
        switch status {
        case .ready:
            DispatchQueue.main.async {
                self.searchResultView.isHidden = true
                self.searchKeywordView.isHidden = true
                self.recentKeywordView.isHidden = false
                self.recentKeywordView.reloadData()
            }
        case .startSearch:
            DispatchQueue.main.async {
                self.searchResultView.isHidden = false
                self.searchKeywordView.isHidden = true
                self.recentKeywordView.isHidden = true
                self.searchResultView.reloadData()
            }
        case .editKeyword:
            DispatchQueue.main.async {
                self.searchResultView.isHidden = true
                self.searchKeywordView.isHidden = false
                self.recentKeywordView.isHidden = true
                self.searchKeywordView.reloadData()
            }
        }
    }
}

extension Search: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        Log.Debug(.UI, searchBar.text ?? "")
        if let text = searchBar.text {
            viewModel.requestSearch(keyword: text)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.requestClear()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        updateScreen(status: .editKeyword)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchKeyword(text: searchText)
    }
}

extension Search: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Log.Debug(.UI, "\(tableView.tag)")
        Log.Debug(.UI, "\(indexPath.row)")
        
        if ScreenType(rawValue: tableView.tag) == .SearchResultType {
            let storyboard = UIStoryboard(name: "SearchDetail", bundle: Bundle.main)
            guard let controller = storyboard.instantiateViewController(withIdentifier: "SearchDetail") as? SearchDetail else {
                Log.Debug(.UI, "failed to get controller")
                return
            }
            controller.viewData = viewModel.baseData[indexPath.row]
            self.navigationController?.pushViewController(controller, animated: true)
        } else if ScreenType(rawValue: tableView.tag) == .SearchKeywordType {
            let keyword = viewModel.matchKeyword[indexPath.row]
            viewModel.requestSearch(keyword: keyword)
            DispatchQueue.main.async {
                self.navigationItem.searchController?.searchBar.text = keyword
            }
        } else { // .RecentKeyword
            let keyword = viewModel.searchHistory[indexPath.row]
            viewModel.requestSearch(keyword: keyword)
            DispatchQueue.main.async {
                self.navigationItem.searchController?.searchBar.text = keyword
            }
        }
    }
}

extension Search: UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        Log.Debug(.UI, "\(tableView.tag)")
        switch ScreenType(rawValue: tableView.tag) {
        case .RecentKeywordType:
            return "최근 검색어"
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Log.Debug(.UI, "\(tableView.tag)")
        switch ScreenType(rawValue: tableView.tag) {
        case .SearchKeywordType:
            return viewModel.matchKeyword.count > 10 ? 10 : viewModel.matchKeyword.count
        case .SearchResultType:
            return viewModel.viewData.count
        case .RecentKeywordType:
            return viewModel.searchHistory.count > 5 ? 5 : viewModel.searchHistory.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        Log.Debug(.UI, "\(tableView.tag)")
        
        if ScreenType(rawValue: tableView.tag) == .SearchResultType {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResult", for: indexPath) as? SearchResult else {
                return UITableViewCell()
            }
            cell.setupCell(data: viewModel.viewData[indexPath.row])
            return cell
        } else if ScreenType(rawValue: tableView.tag) == .SearchKeywordType {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchKeyword", for: indexPath) as? SearchKeyword else {
                return UITableViewCell()
            }
            cell.searchKeyword.text = viewModel.matchKeyword[indexPath.row]
            return cell
        } else { // .RecentKeyword
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecentKeyword", for: indexPath) as? RecentKeyword else {
                return UITableViewCell()
            }
            cell.recentKeyword.text = viewModel.searchHistory[indexPath.row]
            return cell
        }
    }
}
