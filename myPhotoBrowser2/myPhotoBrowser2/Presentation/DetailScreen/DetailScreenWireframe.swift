//
//  DetailScreenWireframe.swift
//  myPhotoBrowser
//
//  Created by 김희수 on 2022/03/30.
//

import UIKit

final class DetailScreenWireframe {
    
    private let dataSource: UnsplashDataSourceProtocol
    private let delegate: DetailScreenDataDelegate
    private let data: [PhotoInfo]
    private let position: Int
    private var view: DetailScreenView?
    
    init(dataSource: UnsplashDataSourceProtocol, dataDelegate: DetailScreenDataDelegate, data: [PhotoInfo], position: Int) {
        self.dataSource = dataSource
        self.delegate = dataDelegate
        self.data = data
        self.position = position
    }
    
    func setup() -> UIViewController {
        let interactor = DetailScreenInteractor(dataSource: self.dataSource)
        let presenter = DetailScreenPresenter(interactor: interactor, wireframe: self)
        let storyboard = UIStoryboard(name: "DetailScreen", bundle: Bundle.main)
        let view = storyboard.instantiateViewController(identifier: "DetailScreen", creator: { coder -> DetailScreenView? in
            return .init(coder: coder,
                         presenter: presenter,
                         dataDelegate: self.delegate,
                         currentIdx: self.position,
                         viewData: self.data)
        })
        self.view = view
        return view
    }

    func routeToInfoScreen(id: String) {

    }
    
    func routeToBrowseScreen() {
        self.view?.dismiss(animated: true, completion: nil)
    }
}
