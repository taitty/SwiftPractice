//
//  DetailScreenViewController.swift
//  myMovieGuide
//
//  Created 김희수 on 2022/01/28.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol DetailScreenViewProtocol: AnyObject {
    func updateScreen(data: DetailScreenContent)
}

final class DetailScreenViewController: UIViewController {
    var presenter: DetailScreenPresenterProtocol!

    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var playerLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UITextView!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var etcLabel: UILabel!
    
    private var detailScreenViewData: DetailScreenContent? {
        didSet {
            DispatchQueue.main.async {
                if let imageUrl = URL(string: self.detailScreenViewData?.image ?? ""), let data = try? Data(contentsOf: imageUrl) {
                    self.posterImage.image = UIImage(data: data)
                }
                self.directorLabel.text = self.detailScreenViewData?.director
                self.playerLabel.text = self.detailScreenViewData?.player
                self.descriptionLabel.text = self.detailScreenViewData?.description
                self.genresLabel.text = self.detailScreenViewData?.genres
                self.etcLabel.text = self.detailScreenViewData?.etc
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configuration()
        presenter.onViewDidLoad()
    }
    
    private func configuration() {
        detailScreenViewData = try? DIContainer.resolve(DetailScreenContent.self)

        self.navigationItem.title = detailScreenViewData?.title
    }
}

// MARK: - ViewProtocol
extension DetailScreenViewController: DetailScreenViewProtocol {
    
    func updateScreen(data: DetailScreenContent) {
        detailScreenViewData = data;
        Log.Debug(.UI, "viewData is updated")
    }
    
}
