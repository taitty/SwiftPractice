//
//  HomeScreenInteractor.swift
//  myMovieGuide
//
//  Created 김희수 on 2022/01/26.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import ReactiveSwift

protocol HomeScreenInteractorProtocol: AnyObject {
    func requestHomeData(completion: @escaping ([HomeScreenCategory]) -> Void)
    func prepareChangeToDetailScreen(data: HomeScreenCategoryContent?)
}

final class HomeScreenInteractor {
    
    weak var presenter: HomeScreenPresenterProtocol!
    private var disposables = CompositeDisposable()
    
    deinit {
        disposables.dispose()
        Log.Debug(.UI, "")
    }
    
    private func convertData(from: [MovieGuideContentList]) -> [HomeScreenCategory] {
        from.compactMap {
            HomeScreenCategory(type: $0.category,
                               title: $0.category.titleString,
                               contents: $0.data.compactMap {
                HomeScreenCategoryContent(id: $0.id,
                                  image: $0.imgPath,
                                  title: $0.title,
                                  releaseDate: $0.releaseDate,
                                  voting: $0.voting)
            })
        }
    }
}

extension HomeScreenInteractor: HomeScreenInteractorProtocol {
    
    func requestHomeData(completion: @escaping ([HomeScreenCategory]) -> Void) {
        guard let useCase = try? DIContainer.resolve(GetTmdbCategoryDataUseCase.self) else {
            Log.Debug(.UI, "GetHomeDataUseCase is not registered")
            return
        }

        self.disposables += useCase.execute().startWithResult { result in
            switch result {
            case .success(let value):
                completion(self.convertData(from: value))
            case .failure(let error):
                Log.Debug(.UI, error.message)
            }
        }
    }
    
    func prepareChangeToDetailScreen(data: HomeScreenCategoryContent?) {
        guard let nextData = try? DIContainer.resolve(DetailScreenContent.self) else {
            Log.Debug(.UI, "DetailScreenContent is not registered")
            return
        }
        nextData.id = data?.id
        nextData.title = data?.title
        nextData.image = data?.image
    }
}
