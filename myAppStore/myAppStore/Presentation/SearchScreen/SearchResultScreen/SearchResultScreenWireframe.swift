//
//  SearchResultScreenWireframe.swift
//  myAppStore
//
//  Created by 김희수 on 2022/03/23.
//

import UIKit

protocol SearchResultScreenWireframeProtocol {
    func routeToDetailScreen(data: SearchModel?)
}

final class SearchResultScreenWireframe {
    
    private var view: UIViewController?
    private var dataSource: AppStoreDataSourceProtocol?
    
    init(dataSource: AppStoreDataSourceProtocol?) {
        self.dataSource = dataSource
    }
    
    func create() -> UIViewController {
        let presenter = SearchResultScreenPresenter()
        let interactor = SearchResultScreenInteractor(dataSource: dataSource)
        let storyboard = UIStoryboard(name: "SearchResultScreen", bundle: Bundle.main)
        let view = storyboard.instantiateViewController(withIdentifier: "SearchResultScreen") as? SearchResultScreenViewController

        self.view = view
        view?.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireframe = self
        
        guard let view = view else {
            Log.Debug(.UI, "failed to create SearchResultScreen...")
            return UIViewController()
        }
        return UINavigationController(rootViewController: view)
    }
    
    func push(from: UIViewController) {
        guard let view = view else {
            Log.Debug(.UI, "SearchResultScreen is not created...")
            return
        }
        from.navigationController?.pushViewController(view, animated: true)
    }
}

extension SearchResultScreenWireframe: SearchResultScreenWireframeProtocol {
    
    func routeToDetailScreen(data: SearchModel?) {
        guard let view = view else {
            Log.Debug(.UI, "SearchResultScreen is not created...")
            return
        }
        let wireframe = SearchDetailScreenWireframe()
        wireframe.create(data: data)
        wireframe.push(from: view)
    }
}
