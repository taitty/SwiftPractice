//
//  DetailScreenViewController.swift
//  myPhotoBrowser
//
//  Created by 김희수 on 2022/03/30.
//

import UIKit

final class DetailScreenViewController: UIViewController {
    
    var presenter: DetailScreenPresenterProtocol?
    
    @IBOutlet weak var detailListView: UICollectionView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var infoButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailListView.delegate = self
        detailListView.dataSource = self
        
        registerCell()
    }
    
    private func registerCell() {
        let name = UINib(nibName: "DetailCell", bundle: Bundle.main)
        detailListView.register(name, forCellWithReuseIdentifier: "DetailCell")
    }
    
    @IBAction func pressInfoButton(_ sender: UIButton) {
        let wireframe = InfoScreenWireframe(dataSource: "test")
        wireframe.setup()
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
    
}

extension DetailScreenViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "DetailCell", for: indexPath)
    }
    
}

extension DetailScreenViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: detailListView.frame.size.width  , height:  detailListView.frame.height)
    }
}
