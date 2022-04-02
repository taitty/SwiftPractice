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
    
    private var currentIdx: Int?
    private var viewData: [PhotoInfo]?
    private var cancellable = Set<AnyCancellable>()
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var imageListView: UICollectionView!
    @IBOutlet weak var noResultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageListView.delegate = self
        imageListView.dataSource = self
        
        searchBar.delegate = self
        searchBar.placeholder = "Search Photos"
        
        noResultLabel.isHidden = true
        
        registerCell()
        setObserver()
        
        presenter?.onViewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        guard let data = viewData, !data.isEmpty else { return }
        if let focus = currentIdx {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.imageListView.scrollToItem(at: IndexPath(row: focus, section: 0), at: .top, animated: false)
            }
        }
    }
    
    private func registerCell() {
        let name = UINib(nibName: "ImageCell", bundle: Bundle.main)
        imageListView.register(name, forCellWithReuseIdentifier: "ImageCell")
    }
    
    private func setObserver() {
        presenter?.dataObserver.dropFirst().sink {
            Log.Debug(.UI, "new data is updated")
            self.viewData = $0
            
            var hideMessage = false
            if let data = self.viewData, !data.isEmpty {
                hideMessage = true
            }
            
            DispatchQueue.main.async {
                self.noResultLabel.isHidden = hideMessage
                self.imageListView.reloadData()
            }
        }.store(in: &cancellable)
        
        presenter?.screenModeObserver.dropFirst().sink { _ in
            self.currentIdx = 0
            guard let data = self.viewData, !data.isEmpty else { return }
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.imageListView.scrollToItem(at: IndexPath(row: self.currentIdx ?? 0, section: 0), at: .top, animated: false)
            }
        }.store(in: &cancellable)
    }
    
}

extension BrowseScreenViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        Log.Debug(.UI, searchBar.text ?? "")
        if let text = searchBar.text {
            presenter?.requestSearch(keyword: text)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        Log.Debug(.UI, "search canceled...")
        self.searchBar.showsCancelButton = false
        presenter?.searchCanceled()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            presenter?.searchCanceled()
        }
    }
    
}

extension BrowseScreenViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentIdx = indexPath.row
        presenter?.itemSelected()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        for cell in imageListView.visibleCells {
            let indexPath = imageListView.indexPath(for: cell)
            if let index = indexPath?.row, let count = viewData?.count, index > (count - 5) {
                presenter?.reachedLastItem()
            }
        }
    }
    
}

extension BrowseScreenViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as? ImageCell,
              let cellData = viewData?[indexPath.row]  else {
            return UICollectionViewCell()
        }

        cell.artist.text = cellData.artist
        if let imageUrl = URL(string: cellData.smlImgUrl ?? ""), let data = try? Data(contentsOf: imageUrl) {
            cell.imageView.image = UIImage(data: data)
        }
        return cell
    }
    
}

extension BrowseScreenViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let photoWidth = CGFloat(viewData?[indexPath.row].width ?? 1)
        let photoHeight = CGFloat(viewData?[indexPath.row].height ?? 1)
        let ratio = photoHeight / photoWidth
        let height = imageListView.frame.width * ratio
        return CGSize(width: imageListView.frame.size.width, height: height)
    }
    
}

extension BrowseScreenViewController: DetailScreenDataDelegate {
    
    func getCurrentPosition() -> Int {
        return self.currentIdx ?? 0
    }
    
    func setCurrentPosition(position: Int) {
        self.currentIdx = position
    }
    
    func getViewData() -> [PhotoInfo]? {
        return self.viewData
    }

}
