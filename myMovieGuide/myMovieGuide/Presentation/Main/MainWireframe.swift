//
//  MainWireframe.swift
//  myMovieGuide
//
//  Created 김희수 on 2022/01/27.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol MainWireframeProtocol: AnyObject {
    func routeToHomeScreen(from: UIViewController)
}

final class MainWireframe {

    init() {}

}

extension MainWireframe:MainWireframeProtocol {
    
    func routeToHomeScreen(from: UIViewController) {
        guard let next = try? DIContainer.resolve(HomeScreenWireframe.self) else {
            Log.Debug(.UI, "failed to resolve HomeScreenWireframe")
            return
        }
        let nextVC = next.setup()
        nextVC.modalPresentationStyle = .fullScreen
        DispatchQueue.main.async {
            from.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    
}
