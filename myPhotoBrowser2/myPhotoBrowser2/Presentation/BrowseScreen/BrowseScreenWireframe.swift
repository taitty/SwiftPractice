//
//  BrowseScreenWireframe.swift
//  myPhotoBrowser
//
//  Created by 김희수 on 2022/03/30.
//

import UIKit

struct BrowseScreenWireframe {
    
    private let dataSource: UnsplashDataSourceProtocol
    
    init(dataSource: UnsplashDataSourceProtocol) {
        self.dataSource = dataSource
    }
    
    func setup() -> UIViewController {
        let interactor = BrowseScreenInteractor(dataSource: dataSource)
        let presenter = BrowseScreenPresenter(interactor: interactor, wireframe: self)
        let storyboard = UIStoryboard(name: "BrowseScreen", bundle: Bundle.main)
        let view = storyboard.instantiateViewController(identifier: "BrowseScreen", creator: { coder -> BrowseScreenView? in
            return .init(coder: coder, presenter: presenter)
        })
        return view
    }
    
    func routeToDetailScreen(data: [PhotoInfo], position: Int) {

    }
}
