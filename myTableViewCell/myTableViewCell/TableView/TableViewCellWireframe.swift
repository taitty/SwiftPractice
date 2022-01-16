//
//  TableViewCellWireframe.swift
//  socialPlatform
//
//  Created by 김희수 on 2022/01/06.
//

import UIKit

protocol TableViewCellWireframeProtocol {
    
}

final class TableViewCellWireframe {

    func setup() -> UIViewController {
        let storyboard = UIStoryboard(name: "TableViewCell", bundle: Bundle.main)
        let view = storyboard.instantiateViewController(identifier: "TableViewCell") as! TableViewCellViewController
        let presenter = TableViewCellPresenter()
        let interactor = TableViewCellInteractor()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.wireframe = self
        presenter.interactor = interactor
        
        interactor.presenter = presenter
        
        return view
    }
    
}

extension TableViewCellWireframe: TableViewCellWireframeProtocol {
    
}
