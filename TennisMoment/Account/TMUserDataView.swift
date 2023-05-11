//
//  TMUserDataView.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/3/10.
//

import Foundation
import JXSegmentedView
import TMComponent

class TMUserDataView: TMView {
    var segmentedDataSource: JXSegmentedBaseDataSource?
    let segmentedView = JXSegmentedView()
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
        let titles = [NSLocalizedString("ACTIVITY", comment: ""), NSLocalizedString("STATS", comment: "")]

        let dataSource = JXSegmentedTitleDataSource()
        dataSource.isTitleColorGradientEnabled = true
        dataSource.titleNormalColor = UIColor(named: "ContentBackground") ?? .black
        dataSource.titleSelectedColor = .black
        dataSource.titles = titles
        segmentedDataSource = dataSource
        // 配置指示器
        let indicator = JXSegmentedIndicatorBackgroundView()
        indicator.indicatorHeight = 30
        indicator.indicatorColor = UIColor(named: "TennisBlur") ?? .blue
        segmentedView.indicators = [indicator]

        segmentedView.dataSource = segmentedDataSource
        segmentedView.delegate = self
        segmentedView.listContainer = listContainerView
        addSubview(segmentedView)
        addSubview(listContainerView)
        gameStatsView.setupUI()
        careerStatsView.setupUI()

        segmentedView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
        }
        listContainerView.snp.makeConstraints { make in
            make.top.equalTo(segmentedView.snp.bottom)
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }

    func setupEventForGameStatsView(games: [Game]) {
        gameStatsView.setupEvent(games: games)
    }

    func setupEventForCareerStatsView() {
        careerStatsView.setupEvent(stats: TMUser.user.careerStats)
    }
}

extension TMUserDataView: JXSegmentedListContainerViewDataSource {
    func numberOfLists(in _: JXSegmentedListContainerView) -> Int {
        if let titleDataSource = segmentedView.dataSource as? JXSegmentedBaseDataSource {
            return titleDataSource.dataSource.count
        }
        return 0
    }

    func listContainerView(_: JXSegmentedListContainerView, initListAt: Int) -> JXSegmentedListContainerViewListDelegate {
        if initListAt == 0 {
            return gameStatsView
        }
        return careerStatsView
    }
}

extension TMUserDataView: JXSegmentedViewDelegate {
    func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int) {
        if let dotDataSource = segmentedDataSource as? JXSegmentedDotDataSource {
            // 先更新数据源的数据

            dotDataSource.dotStates[index] = false
            // 再调用reloadItem(at: index)
            segmentedView.reloadItem(at: index)
        }
    }
}
