//
//  BrowseScreenViewController.swift
//  myPhotoBrowser
//
//  Created by 김희수 on 2022/03/30.
//

import UIKit
import Combine

final class BrowseScreenViewController: UIViewController {
    
    var presenter: BrowseScreenPresenterProtocol?
    private var viewData: [PhotoInfo] = []
    private var cancellable = Set<AnyCancellable>()
    
    @IBOutlet weak var imageListView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageListView.delegate = self
        imageListView.dataSource = self
        
        registerCell()
        configSearchBar()
        setObserver()
        
        presenter?.onViewDidLoad()
    }
    
    private func registerCell() {
        let name = UINib(nibName: "ImageCell", bundle: Bundle.main)
        imageListView.register(name, forCellWithReuseIdentifier: "ImageCell")
    }
    
    private func configSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search Photos"
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.searchController = searchController
    }
    
    private func setObserver() {
        let dataObserver = presenter?.dataChecker
        dataObserver?.sink {
            if !$0.isEmpty {
                Log.Debug(.UI, "new data is updated")
                self.viewData = $0
                DispatchQueue.main.async {
                    self.imageListView.reloadData()
                }
            }
        }.store(in: &cancellable)
    }
    
}

extension BrowseScreenViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        Log.Debug(.UI, searchBar.text ?? "")
        if let text = searchBar.text {
//            presenter?.requestSearch(keyword: text)
        }
    }
    
}

extension BrowseScreenViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.cellSelected(id: viewData[indexPath.row].id)
    }
    
}

extension BrowseScreenViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as? ImageCell else {
            return UICollectionViewCell()
        }
        
        let cellData = viewData[indexPath.row]
        cell.artist.text = cellData.artist
        if let imageUrl = URL(string: cellData.smlImgUrl ?? ""), let data = try? Data(contentsOf: imageUrl) {
            cell.imageView.image = UIImage(data: data)
        }
        
        return cell
    }
    
}

extension BrowseScreenViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let photoWidth = CGFloat(viewData[indexPath.row].width ?? 1)
        let photoHeight = CGFloat(viewData[indexPath.row].height ?? 1)
        let ratio = photoHeight / photoWidth
        let height = imageListView.frame.width * ratio
        return CGSize(width: imageListView.frame.size.width, height: height)
    }
    
}
