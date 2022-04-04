//
//  DetailScreenViewController.swift
//  myPhotoBrowser
//
//  Created by 김희수 on 2022/03/30.
//

import UIKit

protocol DetailScreenDataDelegate {
    func setCurrentPosition(position: Int)
}

final class DetailScreenViewController: UIViewController {
    
    var presenter: DetailScreenPresenterProtocol?
    var viewData: [PhotoInfo]?
    var currentIdx: Int?
    var dataDelegate: DetailScreenDataDelegate?
    
    @IBOutlet weak var detailListView: UICollectionView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var artistLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailListView.delegate = self
        detailListView.dataSource = self
        
        registerCell()
        configuration()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let data = viewData, !data.isEmpty else { return }
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.artistLabel.text = self.viewData?[self.currentIdx ?? 0].artist
            self.detailListView.scrollToItem(at: IndexPath(row: self.currentIdx ?? 0, section: 0), at: .left, animated: false)
        }
    }
    
    private func registerCell() {
        let name = UINib(nibName: "DetailCell", bundle: Bundle.main)
        detailListView.register(name, forCellWithReuseIdentifier: "DetailCell")
    }
    
    private func configuration() {

    }
    
    @IBAction func pressInfoButton(_ sender: UIButton) {
        guard let idx = currentIdx, let id = viewData?[idx].id else { return }
        presenter?.pressInfoButton(contentId: id)
    }
    
    @IBAction func pressCloseButton(_ sender: UIButton) {
        dataDelegate?.setCurrentPosition(position: currentIdx ?? 0)
        presenter?.pressCloseButton()
    }
}

extension DetailScreenViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.headerView.isHidden = !self.headerView.isHidden
        self.infoButton.isHidden = !self.infoButton.isHidden
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        for cell in detailListView.visibleCells {
            let indexPath = detailListView.indexPath(for: cell)
            if let index = indexPath?.row {
                currentIdx = index
                artistLabel.text = viewData?[index].artist
            }
        }
    }
}

extension DetailScreenViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailCell", for: indexPath) as? DetailCell,
              let cellData = viewData?[indexPath.row]  else {
            return UICollectionViewCell()
        }

        cell.imageView.getImage(urlString: cellData.smlImgUrl ?? "")
        return cell
    }
    
}

extension DetailScreenViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: detailListView.frame.size.width  , height:  detailListView.frame.height)
    }
}
