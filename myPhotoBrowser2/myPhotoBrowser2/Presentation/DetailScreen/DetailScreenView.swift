//
//  DetailScreenView.swift
//  myPhotoBrowser
//
//  Created by 김희수 on 2022/03/30.
//

import UIKit

protocol DetailScreenDataDelegate {
    func setCurrentPosition(position: Int)
}

final class DetailScreenView: UIViewController {
    
    private let presenter: DetailScreenPresenter
    private let dataDelegate: DetailScreenDataDelegate
    private let viewData: [PhotoInfo]
    private var currentIdx: Int
    
    @IBOutlet weak var detailListView: UICollectionView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var artistLabel: UILabel!
    
    
    init?(coder: NSCoder, presenter: DetailScreenPresenter, dataDelegate: DetailScreenDataDelegate, currentIdx: Int, viewData: [PhotoInfo]) {
        self.presenter = presenter
        self.dataDelegate = dataDelegate
        self.currentIdx = currentIdx
        self.viewData = viewData
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailListView.delegate = self
        detailListView.dataSource = self
        
        registerCell()
        configuration()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard viewData.isNotEmpty else { return }
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.artistLabel.text = self.viewData[self.currentIdx].artist
            self.detailListView.scrollToItem(at: IndexPath(row: self.currentIdx, section: 0), at: .left, animated: false)
        }
    }
    
    private func registerCell() {
        let name = UINib(nibName: "DetailCell", bundle: Bundle.main)
        detailListView.register(name, forCellWithReuseIdentifier: "DetailCell")
    }
    
    private func configuration() {

    }
    
    @IBAction func pressInfoButton(_ sender: UIButton) {
        guard viewData.isNotEmpty else { return }
        presenter.pressInfoButton(contentId: viewData[currentIdx].id)
    }
    
    @IBAction func pressCloseButton(_ sender: UIButton) {
        dataDelegate.setCurrentPosition(position: currentIdx)
        presenter.pressCloseButton()
    }
}

extension DetailScreenView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.headerView.isHidden = !self.headerView.isHidden
        self.infoButton.isHidden = !self.infoButton.isHidden
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        for cell in detailListView.visibleCells {
            let indexPath = detailListView.indexPath(for: cell)
            if let index = indexPath?.row {
                currentIdx = index
                artistLabel.text = viewData[index].artist
            }
        }
    }
}

extension DetailScreenView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailCell", for: indexPath) as? DetailCell else {
            return UICollectionViewCell()
        }

        cell.imageView.getImage(urlString: viewData[indexPath.row].smlImgUrl)
        return cell
    }
    
}

extension DetailScreenView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: detailListView.frame.size.width  , height:  detailListView.frame.height)
    }
}
