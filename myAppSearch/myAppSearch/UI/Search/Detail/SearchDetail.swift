//
//  SearchDetail.swift
//  myAppSearch
//
//  Created by 김희수 on 2023/03/19.
//

import UIKit

final class SearchDetail: UIViewController {
    
    @IBOutlet weak var contentView: UIStackView!
    
    var viewData: AppInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Log.Debug(.UI, "\(String(describing: viewData))")
        
        setupSubViews()
    }
    
    private func setupSubViews() {
        guard let data = viewData else {
            Log.Debug(.UI, "data is empty")
            return
        }
        
        let titleViewData = TitleViewRequirement(appIcon: data.appIcon, appTitle: data.appTitle, subTitle: data.summary)
        let titleView = TitleView()
        titleView.configuration(data: titleViewData)
        contentView.addArrangedSubview(titleView)
 
        let infoData = InfoScrollViewRequirement(infoData: data.info)
        let infoView = InfoScrollView()
        infoView.configuration(data: infoData)
        contentView.addArrangedSubview(infoView)
        
        let featureData = NewFeatureViewRequirement(version: data.version, description: data.guide)
        let featureView = NewFeatureView()
        featureView.configuration(data: featureData)
        contentView.addArrangedSubview(featureView)
        
        let previewData = PreviewListViewRequirement(imagePath: data.previewImage)
        let previewView = PreviewListView()
        previewView.configuration(data: previewData)
        contentView.addArrangedSubview(previewView)
    }
}
