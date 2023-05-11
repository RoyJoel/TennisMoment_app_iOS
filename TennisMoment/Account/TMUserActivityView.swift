//
//  TMUserActivityView.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/3/10.
//

import Foundation
import JXSegmentedView
import SnapKit
import UIKit

class TMUserActivityView: UIView {
    lazy var leftActivityView: TMGameStatsView = {
        let view = TMGameStatsView()
        return view
    }()

    lazy var midActivityView: TMGameStatsView = {
        let view = TMGameStatsView()
        return view
    }()

    lazy var rightActivityView: TMGameStatsView = {
        let view = TMGameStatsView()
        return view
    }()

    // 无比赛时提示窗口
    lazy var alartView: UILabel = {
        let view = UILabel()
        return view
    }()

    func setupUI() {
        leftActivityView.isHidden = false
        midActivityView.isHidden = false
        rightActivityView.isHidden = false
        alartView.isHidden = true

        addSubview(leftActivityView)
        addSubview(midActivityView)
        addSubview(rightActivityView)

        let width = (UIStandard.shared.screenWidth - 132) / 3
        leftActivityView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.width.equalTo(width)
            make.height.equalTo(288)
            make.centerY.equalToSuperview()
        }
        midActivityView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(width)
            make.height.equalTo(288)
            make.centerY.equalToSuperview()
        }
        rightActivityView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-12)
            make.width.equalTo(width)
            make.height.equalTo(288)
            make.centerY.equalToSuperview()
        }

        leftActivityView.setupUI()
        midActivityView.setupUI()
        rightActivityView.setupUI()
    }

    func setupAlart() {
        leftActivityView.isHidden = true
        midActivityView.isHidden = true
        rightActivityView.isHidden = true
        alartView.isHidden = false

        addSubview(alartView)
        alartView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(40)
        }
        let lastGameTime = UserDefaults.standard.double(forKey: TMUDKeys.lastGameTime.rawValue)
        if lastGameTime == 0 {
            alartView.text = NSLocalizedString("Your history matches will be here", comment: "")
        } else {
            let gap = Date().timeIntervalSince1970 - lastGameTime
            let days = Int(gap / (24 * 3600))
            let hours = Int((gap / 3600).truncatingRemainder(dividingBy: 24))
            alartView.text = String(format: NSLocalizedString("lastGameTime", comment: ""), days, hours)
        }
        alartView.font = UIFont.systemFont(ofSize: 22)
        alartView.textAlignment = .center
    }

    func setupEvent(games: [Game]) {
        if games.count >= 3 {
            leftActivityView.isHidden = false
            midActivityView.isHidden = false
            rightActivityView.isHidden = false
            let width = (UIStandard.shared.screenWidth - 112) / 3
            leftActivityView.snp.remakeConstraints { make in
                make.left.equalToSuperview()
                make.width.equalTo(width)
                make.height.equalTo(288)
                make.centerY.equalToSuperview()
            }
            midActivityView.snp.remakeConstraints { make in
                make.centerX.equalToSuperview()
                make.width.equalTo(width)
                make.height.equalTo(288)
                make.centerY.equalToSuperview()
            }
            rightActivityView.snp.remakeConstraints { make in
                make.right.equalToSuperview()
                make.width.equalTo(width)
                make.height.equalTo(288)
                make.centerY.equalToSuperview()
            }
            leftActivityView.setupEvent(game: games[0])
            midActivityView.setupEvent(game: games[1])
            rightActivityView.setupEvent(game: games[2])
        } else if games.count == 2 {
            leftActivityView.isHidden = false
            rightActivityView.isHidden = false
            midActivityView.isHidden = true
            let width = (UIStandard.shared.screenWidth - 88) / 3
            leftActivityView.snp.remakeConstraints { make in
                make.left.equalToSuperview().offset(width / 3)
                make.width.equalTo(width)
                make.height.equalTo(288)
                make.centerY.equalToSuperview()
            }
            rightActivityView.snp.remakeConstraints { make in
                make.right.equalToSuperview().offset(-(width / 3))
                make.width.equalTo(width)
                make.height.equalTo(288)
                make.centerY.equalToSuperview()
            }
            leftActivityView.setupEvent(game: games[0])
            rightActivityView.setupEvent(game: games[1])
        } else if games.count == 1 {
            leftActivityView.isHidden = true
            rightActivityView.isHidden = true
            midActivityView.isHidden = false
            let width = (UIStandard.shared.screenWidth - 88) / 3
            midActivityView.snp.remakeConstraints { make in
                make.centerX.equalToSuperview()
                make.width.equalTo(width)
                make.height.equalTo(288)
                make.centerY.equalToSuperview()
            }
            midActivityView.setupEvent(game: games[0])
        }
    }
}

extension TMUserActivityView: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return self
    }
}
