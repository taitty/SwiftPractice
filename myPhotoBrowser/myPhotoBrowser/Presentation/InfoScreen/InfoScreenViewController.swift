//
//  InfoScreenViewController.swift
//  myPhotoBrowser
//
//  Created by 김희수 on 2022/03/30.
//

import UIKit
import MapKit
import Combine

final class InfoScreenViewController: UIViewController {
    
    var presenter: InfoScreenPresenterProtocol?
    private var viewData: PhotoDetail?
    private var cancellable = Set<AnyCancellable>()
    
    @IBOutlet weak var mapContainerView: UIView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var infoListView: UICollectionView!
    @IBOutlet weak var descriptionLabel: UITextView!
    @IBOutlet weak var locationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        infoListView.delegate = self
        infoListView.dataSource = self
        
        registerCell()
        configuration()
        
        presenter?.onViewDidLoad()
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
    
    private func updateScreen() {
        DispatchQueue.main.async {
            self.descriptionLabel.text = self.viewData?.location?.description
            self.locationLabel.text = self.viewData?.location?.location
            
            self.mapView.isHidden = false
            let flowHeightConstraint = self.mapContainerView.heightAnchor.constraint(equalToConstant: 100.0)
            flowHeightConstraint.isActive = true
            
            self.infoListView.reloadData()
        }
    }
    
    private func setObserver() {
        let dataObserver = presenter?.dataChecker
        dataObserver?.sink {
                Log.Debug(.UI, "new data is updated")
                self.viewData = $0
                self.updateScreen()
        }.store(in: &cancellable)
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InfoCell", for: indexPath) as? InfoCell else {
            return UICollectionViewCell()
        }
        
        switch indexPath.row {
        case 0:
            cell.keyLabel.text = viewData?.exif?.maker
        case 1:
            cell.keyLabel.text = viewData?.exif?.focalLength
        case 2:
            cell.keyLabel.text = viewData?.exif?.model
        case 3:
            cell.keyLabel.text = String(viewData?.exif?.iso ?? 0)
        case 4:
            cell.keyLabel.text = viewData?.exif?.shutterSpeed
        case 5:
            cell.keyLabel.text = viewData?.exif?.dimension
        case 6:
            cell.keyLabel.text = viewData?.exif?.aperture
        default:
            cell.keyLabel.text = viewData?.exif?.published
        }
        
        return cell
    }
    
}

extension InfoScreenViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: infoListView.frame.size.width*0.45  , height:  50.0)
    }
}
