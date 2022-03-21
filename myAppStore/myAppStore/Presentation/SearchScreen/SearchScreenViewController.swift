//
//  SearchScreenViewController.swift
//  myAppStore
//
//  Created by 김희수 on 2022/03/19.
//

import UIKit
import ReactiveSwift

protocol SearchScreenDelegate: AnyObject {
    func getSelectedItem() -> SearchModel?
}

class SearchScreenViewController: UIViewController {

    private var viewModel = SearchScreenViewModel()
    private var disposables = CompositeDisposable()
    
    @IBOutlet weak var searchResultView: UICollectionView!
    @IBOutlet weak var noResultLabel: UILabel!
    
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
        
        noResultLabel.isHidden = true
        
        registerCell()
        setupObserver()
        setupSearchBar()
    }
    
    private func registerCell() {
        let nib = UINib(nibName: "SearchResultCell", bundle: nil)
        searchResultView.register(nib, forCellWithReuseIdentifier: "SearchResultCell")
    }
    
    private func setupObserver() {
        disposables += viewModel.viewData.signal.observeValues { data in
            DispatchQueue.main.async {
                self.noResultLabel.isHidden = !data.isEmpty
                self.searchResultView.reloadData()
            }
        }
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

extension SearchScreenViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.setSelectedItem(index: indexPath.row)

        let storyboard = UIStoryboard(name: "SearchDetailScreen", bundle: Bundle.main)
        guard let nextVC = storyboard.instantiateViewController(withIdentifier: "SearchDetailScreen") as? SearchDetailScreenViewController else {
            Log.Debug(.UI, "SearchDetailScreen is invalid...")
            return
        }
        nextVC.delegate = self
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
        let rating = round((data.rating ?? 0) * 10) / 10
        cell.ratingStar.rating = rating
        cell.ratingStar.text = String(rating)
        if let thumbnail = data.previewImage {
            let max = thumbnail.count > 3 ? 3 : thumbnail.count
            for i in 0..<max {
                if let imgUrl = URL(string: thumbnail[i]), let data = try? Data(contentsOf: imgUrl) {
                    cell.thumbnail[i].image = UIImage(data: data)
                }
            }
        }
        return cell
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

extension SearchScreenViewController: SearchScreenDelegate {
    
    func getSelectedItem() -> SearchModel? {
        return viewModel.getSelectedItem()
    }
}
