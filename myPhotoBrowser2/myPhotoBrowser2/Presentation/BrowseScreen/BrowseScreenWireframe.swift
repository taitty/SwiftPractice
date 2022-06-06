//
//  BrowseScreenWireframe.swift
//  myPhotoBrowser
//
//  Created by 김희수 on 2022/03/30.
//

import UIKit

final class BrowseScreenWireframe {
    
    private let dataSource: UnsplashDataSourceProtocol
    private var view: BrowseScreenView?
    
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
        self.view = view
        return view
    }
    
    func routeToDetailScreen(data: [PhotoInfo], position: Int) {
        guard let view = self.view else { return }
        let wireframe = DetailScreenWireframe(dataSource: self.dataSource, dataDelegate: view, data: data, position: position)
        let next = wireframe.setup()
        next.modalPresentationStyle = .fullScreen
        view.present(next, animated: true)
    }
}
