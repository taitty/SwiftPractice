//
//  HomeWireframe.swift
//  myVIPER
//
//  Created by 김희수 on 2022/05/31.
//

import Foundation
import UIKit

struct HomeWireframe {
    
    let data: String

    func setup() -> UIViewController {
        let interactor = HomeInteractor(data: data)
        let presenter = HomePresenter(interactor: interactor, wireframe: self)
        let storyboard = UIStoryboard(name: "HomeView", bundle: nil)
        let view = storyboard.instantiateViewController(identifier: "HomeView", creator: { coder -> HomeView? in
            return .init(coder: coder, presenter: presenter)
        })
//        guard let view = storyboard.instantiateInitialViewController(creator: { coder -> HomeView? in
//            NSLog("taitty1")
//            return .init(coder: coder, presenter: presenter)
//        }) else {
//            NSLog("failed")
//            return UIViewController()
//        }
        return view
    }
}
