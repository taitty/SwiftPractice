//
//  BrowseScreenView.swift
//  myPhotoBrowser
//
//  Created by 김희수 on 2022/03/30.
//

import UIKit
import Combine

final class BrowseScreenView: UIViewController {
    
    private let presenter: BrowseScreenPresenter
    private var cancellable = Set<AnyCancellable>()
    private var currentIdx: Int = 0
    
    @IBOutlet weak var imageList: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var noResult: UILabel!
    
    private var viewData: [PhotoInfo] = [] {
        didSet {
            let hideMessage = self.viewData.isEmpty ? false : true
            DispatchQueue.main.async {
                self.noResult.isHidden = hideMessage
                self.imageList.reloadData()
            }
        }
    }
    
    init?(coder: NSCoder, presenter: BrowseScreenPresenter) {
        self.presenter = presenter
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageList.delegate = self
        imageList.dataSource = self
        
        searchBar.delegate = self
        searchBar.placeholder = "Search Photos"
        
        noResult.isHidden = true
        
        registerCell()
        setObserver()
        
        presenter.onViewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        guard viewData.isNotEmpty else { return }
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.imageList.scrollToItem(at: IndexPath(row: self.currentIdx, section: 0), at: .top, animated: false)
        }
    }
    
    private func registerCell() {
        let name = UINib(nibName: "ImageCell", bundle: Bundle.main)
        imageList.register(name, forCellWithReuseIdentifier: "ImageCell")
    }
    
    private func setObserver() {
        presenter.$data
            .assign(to: \.viewData, on: self)
            .store(in: &cancellable)
        
        presenter.$screenMode
            .sink { _ in
                self.currentIdx = 0
                if self.viewData.isEmpty { return }
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.imageList.scrollToItem(at: IndexPath(row: self.currentIdx, section: 0), at: .top, animated: false)
                }
            }
            .store(in: &cancellable)
    }

}

extension BrowseScreenView: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        Log.Debug(.UI, searchBar.text ?? "")
        if let text = searchBar.text {
            self.searchBar.endEditing(true)
            presenter.requestSearch(keyword: text)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        Log.Debug(.UI, "search canceled...")
        self.searchBar.showsCancelButton = false
        self.searchBar.endEditing(true)
        presenter.searchCanceled()
    }
    
}

extension BrowseScreenView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentIdx = indexPath.row
        presenter.itemSelected(selected: currentIdx)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        for cell in imageList.visibleCells {
            let indexPath = imageList.indexPath(for: cell)
            if let index = indexPath?.row, index > (viewData.count - 5) {
                presenter.reachedLastItem()
            }
        }
    }
    
}

extension BrowseScreenView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as? ImageCell else {
            return UICollectionViewCell()
        }

        cell.artist.text = viewData[indexPath.row].artist
        cell.imageView.getImage(urlString: viewData[indexPath.row].smlImgUrl)
        return cell
    }
    
}

extension BrowseScreenView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let photoWidth = CGFloat(viewData[indexPath.row].width)
        let photoHeight = CGFloat(viewData[indexPath.row].height)
        let ratio = photoHeight / photoWidth
        let height = imageList.frame.width * ratio
        return CGSize(width: imageList.frame.size.width, height: height)
    }
    
}

extension BrowseScreenView: DetailScreenDataDelegate {
    
    func setCurrentPosition(position: Int) {
        self.currentIdx = position
    }

}
