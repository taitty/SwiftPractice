//
//  SearchResultScreenViewController.swift
//  myAppStore
//
//  Created by 김희수 on 2022/03/19.
//

import UIKit
import ReactiveSwift

protocol SearchResultScreenViewControllerProtocol: AnyObject {
    func updateScreen(showMessage: Bool)
}

final class SearchResultScreenViewController: UIViewController {

    var presenter: SearchResultScreenPresenterProtocol?
    
    @IBOutlet weak var searchResultView: UICollectionView!
    @IBOutlet weak var noResultLabel: UILabel!
    
    override func viewDidLoad() {
        Log.Debug(.UI, "")
        super.viewDidLoad()
        
        configuration()
        presenter?.onViewDidLoad()
    }
    
    private func configuration() {
        searchResultView.delegate = self
        searchResultView.dataSource = self
        
        noResultLabel.isHidden = true
        registerCell()
        setupSearchBar()
    }
    
    private func registerCell() {
        let nib = UINib(nibName: "SearchResultCell", bundle: nil)
        searchResultView.register(nib, forCellWithReuseIdentifier: "SearchResultCell")
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

extension SearchResultScreenViewController: SearchResultScreenViewControllerProtocol {
    
    func updateScreen(showMessage: Bool) {
        DispatchQueue.main.async {
            self.noResultLabel.isHidden = showMessage
            self.searchResultView.reloadData()
        }
    }
    
}

extension SearchResultScreenViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.itemSelected(index: indexPath.row)
    }
}

extension SearchResultScreenViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.getNumOfData() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchResultCell", for: indexPath) as? SearchResultCell else {
            Log.Debug(.UI, "SearchResultCell is not registered...")
            return UICollectionViewCell()
        }
        guard let data = presenter?.getCellData(index: indexPath.row) else {
            Log.Debug(.UI, "data is empty...")
            return UICollectionViewCell()
        }
        
        if let imgUrl = URL(string: data.appIcon ?? ""),
           let data = try? Data(contentsOf: imgUrl) {
            cell.appIcon.image = UIImage(data: data)
        }
        cell.appTitle.text = data.appTitle
        cell.appSummary.text = data.summary
        let rating = round((data.rating ?? 0) * 10) / 10
        cell.ratingStar.rating = rating
        let vote = (data.vote ?? 0) / 10000
        cell.ratingStar.text = String(vote)+"만"
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

extension SearchResultScreenViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        Log.Debug(.UI, searchBar.text ?? "")
        if let text = searchBar.text {
            presenter?.requestSearch(keyword: text)
        }
    }
    
}
