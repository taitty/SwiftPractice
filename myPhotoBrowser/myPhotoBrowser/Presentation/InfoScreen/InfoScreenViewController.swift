//
//  InfoScreenViewController.swift
//  myPhotoBrowser
//
//  Created by 김희수 on 2022/03/30.
//

import UIKit
import MapKit
import Combine

enum ExifKeys: Int, CaseIterable {
    case maker
    case fLength
    case model
    case iso
    case sSpeed
    case dimensions
    case aperture
    case published
    
    var key: String {
        switch self {
        case .maker:
            return "Maker"
        case .fLength:
            return "Focal Length"
        case .model:
            return "Model"
        case .iso:
            return "ISO"
        case .sSpeed:
            return "Shutter Speed"
        case .dimensions:
            return "Dimensions"
        case .aperture:
            return "Aperture"
        case .published:
            return "Published"
        }
    }
}

final class InfoScreenViewController: UIViewController {
    
    var presenter: InfoScreenPresenterProtocol?
    
    private var viewData: PhotoDetail?
    private var hideMap:[NSLayoutConstraint] = []
    private var showMap:[NSLayoutConstraint] = []
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
        setObserver()
        
        presenter?.onViewDidLoad()
    }
    
    private func registerCell() {
        let name = UINib(nibName: "InfoCell", bundle: Bundle.main)
        infoListView.register(name, forCellWithReuseIdentifier: "InfoCell")
    }
    
    private func configuration() {
        mapContainerView.translatesAutoresizingMaskIntoConstraints = false
        hideMap = [ mapContainerView.heightAnchor.constraint(equalToConstant: 0.0) ]
        showMap = [ mapContainerView.heightAnchor.constraint(equalToConstant: 100.0) ]
        hideMap[0].isActive = true
        NSLayoutConstraint.activate(hideMap)
    }
    
    private func setObserver() {
        presenter?.dataObserver.dropFirst().sink {
                Log.Debug(.UI, "new data is updated")
                self.viewData = $0
                self.updateScreen()
        }.store(in: &cancellable)
    }
    
    private func updateScreen() {
        updateMapInfo()
        updateExifInfo()
    }
    
    private func updateMapInfo() {
        DispatchQueue.main.async {
            self.descriptionLabel.text = self.viewData?.location?.description
            self.locationLabel.text = self.viewData?.location?.location
            
            if let latitude = self.viewData?.location?.latitude, let longitude = self.viewData?.location?.longitude {
                NSLayoutConstraint.deactivate(self.hideMap)
                NSLayoutConstraint.activate(self.showMap)
                
                self.mapView.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), latitudinalMeters: 1000, longitudinalMeters: 1000)

                let annotation = MKPointAnnotation()
                annotation.title = self.viewData?.location?.location
                annotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitude))
                self.mapView.addAnnotation(annotation)
            }
        }
    }
    
    private func updateExifInfo() {
        DispatchQueue.main.async {
            self.infoListView.reloadData()
        }
    }
    
    @IBAction func pressCloseButton(_ sender: UIButton) {
        presenter?.pressCloseButton()
    }
    
    private func convertDate(updated: String?) -> String? {
        guard let updated = updated else { return nil }

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let inputDate = formatter.date(from: updated)

        let newFormatter = DateFormatter()
        newFormatter.dateFormat = "MMMM d, yyyy"
        return newFormatter.string(from: inputDate!)
    }
    
    private func getValue(key: ExifKeys) -> String? {
        switch key {
        case .maker:
            return viewData?.exif?.maker
        case .fLength:
            return "f/".appending(viewData?.exif?.focalLength ?? "")
        case .model:
            return viewData?.exif?.model
        case .iso:
            return String(viewData?.exif?.iso ?? 0)
        case .sSpeed:
            return viewData?.exif?.shutterSpeed?.appending("s")
        case .dimensions:
            return viewData?.exif?.dimension
        case .aperture:
            return viewData?.exif?.aperture
        case .published:
            return convertDate(updated: viewData?.exif?.published)
        }
    }
    
}

extension InfoScreenViewController: UICollectionViewDelegate {}

extension InfoScreenViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ExifKeys.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InfoCell", for: indexPath) as? InfoCell else {
            return UICollectionViewCell()
        }
        
        if let cellItem = ExifKeys(rawValue: indexPath.row) {
            cell.keyLabel.text = cellItem.key
            cell.valueLabel.text = getValue(key: cellItem)
        }

        return cell
    }

}

extension InfoScreenViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: infoListView.frame.size.width*0.45  , height:  50.0)
    }
}

extension InfoScreenViewController: MKMapViewDelegate {}
