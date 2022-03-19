//
//  SearchScreenViewController.swift
//  myAppStore
//
//  Created by 김희수 on 2022/03/19.
//

import UIKit

class SearchScreenViewController: UIViewController {

    private var viewModel: SearchScreenViewModelProtocol?
    
    @IBOutlet weak var searchResultView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchButton: UIButton!
    
    override func viewDidLoad() {
        Log.Debug(.UI, "")
        super.viewDidLoad()
        
        configuration()
        viewModel?.onViewDidLoad()
    }
    
    private func configuration() {
        searchResultView.delegate = self
        searchResultView.dataSource = self
        
        let nib = UINib(nibName: "SearchResultCell", bundle: nil)
        searchResultView.register(nib, forCellWithReuseIdentifier: "SearchResultCell")
        
        viewModel = SearchScreenViewModel()
    }
}

extension SearchScreenViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel?.itemSelected(indexPath: indexPath)

        let next = SearchDetailScreenViewController()
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(next, animated: true)
        }
    }
}

extension SearchScreenViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 11
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchResultCell", for: indexPath)
        return cell
    }

}
