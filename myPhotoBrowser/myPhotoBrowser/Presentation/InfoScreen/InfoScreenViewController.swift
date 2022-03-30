//
//  InfoScreenViewController.swift
//  myPhotoBrowser
//
//  Created by 김희수 on 2022/03/30.
//

import UIKit
import MapKit

final class InfoScreenViewController: UIViewController {
    
    var presenter: InfoScreenPresenterProtocol?
    
    @IBOutlet weak var mapContainerView: UIView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var infoListView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        infoListView.delegate = self
        infoListView.dataSource = self
        
        registerCell()
        configuration()
    }
    
    private func registerCell() {
        let name = UINib(nibName: "InfoCell", bundle: Bundle.main)
        infoListView.register(name, forCellWithReuseIdentifier: "InfoCell")
    }
    
    private func configuration() {
        mapView.isHidden = true
        let flowHeightConstraint = mapContainerView.heightAnchor.constraint(equalToConstant: 20.0)
        flowHeightConstraint.isActive = true
    }
    
    @IBAction func pressCloseButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension InfoScreenViewController: UICollectionViewDelegate {}

extension InfoScreenViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "InfoCell", for: indexPath)
    }
    
}

extension InfoScreenViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: infoListView.frame.size.width*0.45  , height:  50.0)
    }
}
