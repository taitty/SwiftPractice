//
//  SearchScreenViewController.swift
//  myAppStore
//
//  Created by 김희수 on 2022/03/19.
//

import UIKit
import ReactiveSwift

class SearchScreenViewController: UIViewController {

    private var viewModel = SearchScreenViewModel()
    private var disposables = CompositeDisposable()
    
    @IBOutlet weak var searchResultView: UICollectionView!
    
    deinit {
        disposables.dispose()
        Log.Debug(.UI, "")
    }
    
    override func viewDidLoad() {
        Log.Debug(.UI, "")
        super.viewDidLoad()
        
        configuration()
        viewModel.onViewDidLoad()
    }
    
    private func configuration() {
        searchResultView.delegate = self
        searchResultView.dataSource = self
        
        registerCell()
        setupObserver()
        setupSearchBar()
    }
    
    private func registerCell() {
        let nib = UINib(nibName: "SearchResultCell", bundle: nil)
        searchResultView.register(nib, forCellWithReuseIdentifier: "SearchResultCell")
    }
    
    private func setupObserver() {
        disposables += viewModel.viewData.producer.skip(while: { $0.isEmpty }).startWithValues { _ in
            DispatchQueue.main.async {
                self.searchResultView.reloadData()
            }
        }
    }
    
    private func setupSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "게임, 앱, 스토리 등"
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.title = "검색"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
}

extension SearchScreenViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.itemSelected(indexPath: indexPath)

        let storyboard = UIStoryboard(name: "SearchDetailScreen", bundle: Bundle.main)
        let nextVC = storyboard.instantiateViewController(withIdentifier: "SearchDetailScreen")
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
}

extension SearchScreenViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.viewData.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchResultCell", for: indexPath) as? SearchResultCell else {
            Log.Debug(.UI, "SearchResultCell is not registered...")
            return UICollectionViewCell()
        }
        let data = viewModel.viewData.value[indexPath.row]
        if let imgUrl = URL(string: data.appIcon ?? ""),
           let data = try? Data(contentsOf: imgUrl) {
            cell.appIcon.image = UIImage(data: data)
        }
        cell.appTitle.text = data.appTitle
        cell.appSummary.text = data.summary
        cell.ratingStar.rating = data.rating ?? 0.0
        cell.ratingStar.text = String(data.rating ?? 0)
        if let preview = data.preview {
            for (index, imgPath) in preview.enumerated() {
                if let imgUrl = URL(string: imgPath), let data = try? Data(contentsOf: imgUrl) {
                    cell.preview[index].image = UIImage(data: data)
                }
            }
        }
        return cell
    }

}

extension SearchScreenViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        Log.Debug(.UI, searchController.searchBar.text ?? "")
    }
    
}

extension SearchScreenViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        Log.Debug(.UI, searchBar.text ?? "")
        if let text = searchBar.text {
            viewModel.requestSearch(keyword: text)
        }
    }
    
}
