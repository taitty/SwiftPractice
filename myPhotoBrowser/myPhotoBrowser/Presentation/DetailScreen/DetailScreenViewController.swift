//
//  DetailScreenViewController.swift
//  myPhotoBrowser
//
//  Created by 김희수 on 2022/03/30.
//

import UIKit

final class DetailScreenViewController: UIViewController {
    
    var presenter: DetailScreenPresenterProtocol?
    var viewData: [PhotoInfo]?
    var currentIdx: Int?
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.async { [weak self] in
            self?.artistLabel.text = self?.viewData?[self?.currentIdx ?? 0].artist
            self?.detailListView.scrollToItem(at: IndexPath(row: self?.currentIdx ?? 0, section: 0), at: .centeredVertically, animated: false)
        }
    }
    
    private func configuration() {

    }
    
    private func registerCell() {
        let name = UINib(nibName: "DetailCell", bundle: Bundle.main)
        detailListView.register(name, forCellWithReuseIdentifier: "DetailCell")
    }
    
    @IBAction func pressInfoButton(_ sender: UIButton) {
        let wireframe = InfoScreenWireframe(dataSource: "test")
        _ = wireframe.setup()
        wireframe.push(from: self)
    }
    
    @IBAction func pressCloseButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
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

        if let imageUrl = URL(string: cellData.smlImgUrl ?? ""), let data = try? Data(contentsOf: imageUrl) {
            cell.imageView.image = UIImage(data: data)
        }
        
        return cell
    }
    
}

extension DetailScreenViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: detailListView.frame.size.width  , height:  detailListView.frame.height)
    }
}
