//
//  TMComImagesView.swift
//  TMMS
//
//  Created by Jason Zhang on 2023/4/22.
//

import Foundation
import JXSegmentedView
import TMComponent
import UIKit

class TMComImagesView: TMView {
    let segmentedView = JXSegmentedView()
    var intros: [String] = []
    lazy var listContainerView: JXSegmentedListContainerView! = {
        JXSegmentedListContainerView(dataSource: self)
    }()

    lazy var gameStatsView: TMUserActivityView = {
        let view = TMUserActivityView()
        return view
    }()

    lazy var careerStatsView: TMUserStatsView = {
        let view = TMUserStatsView()
        return view
    }()

    func setupUI() {
        setCorner(radii: 20)
        backgroundColor = UIColor(named: "BackgroundGray")

        segmentedView.listContainer = listContainerView
        addSubview(listContainerView)
        gameStatsView.setupUI()
        careerStatsView.setupUI()

        listContainerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
}

extension TMComImagesView: JXSegmentedListContainerViewDataSource {
    func numberOfLists(in _: JXSegmentedListContainerView) -> Int {
        intros.count
    }

    func listContainerView(_: JXSegmentedListContainerView, initListAt: Int) -> JXSegmentedListContainerViewListDelegate {
        let containerView = TMComIntroContainerView(image: UIImage(data: intros[initListAt].toPng()))
        return containerView
    }
}

extension TMComImagesView: JXSegmentedViewDelegate {
    func segmentedView(_: JXSegmentedView, didSelectedItemAt _: Int) {}
}
