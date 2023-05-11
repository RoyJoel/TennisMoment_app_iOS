//
//  TMUserInfoView.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/3/10.
//

import Foundation
import TMComponent
import UIKit

class TMUserInfoView: TMView {
    lazy var yearsPlayedView: TMInfoView = {
        let infoView = TMInfoView()
        return infoView
    }()

    lazy var heightView: TMInfoView = {
        let infoView = TMInfoView()
        return infoView
    }()

    lazy var widthView: TMInfoView = {
        let infoView = TMInfoView()
        return infoView
    }()

    lazy var gripView: TMInfoView = {
        let infoView = TMInfoView()
        return infoView
    }()

    lazy var backhandView: TMInfoView = {
        let infoView = TMInfoView()
        return infoView
    }()

    lazy var pointsView: TMInfoView = {
        let infoView = TMInfoView()
        return infoView
    }()

    func setupUI() {
        setCorner(radii: 20)

        addSubview(yearsPlayedView)
        addSubview(heightView)
        addSubview(widthView)
        addSubview(gripView)
        addSubview(backhandView)
        addSubview(pointsView)

        yearsPlayedView.backgroundColor = .white
        heightView.backgroundColor = .white
        widthView.backgroundColor = .white
        gripView.backgroundColor = .white
        backhandView.backgroundColor = .white
        pointsView.backgroundColor = .white

        yearsPlayedView.setCorner(radii: 15)
        heightView.setCorner(radii: 15)
        widthView.setCorner(radii: 15)
        gripView.setCorner(radii: 15)
        backhandView.setCorner(radii: 15)
        pointsView.setCorner(radii: 15)

        yearsPlayedView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(42)
            make.left.equalToSuperview().offset(42)
            make.width.equalTo(170)
            make.height.equalTo(100)
        }

        heightView.snp.makeConstraints { make in
            make.top.equalTo(yearsPlayedView.snp.top)
            make.centerX.equalToSuperview()
            make.width.equalTo(170)
            make.height.equalTo(100)
        }

        widthView.snp.makeConstraints { make in
            make.top.equalTo(yearsPlayedView.snp.top)
            make.right.equalToSuperview().offset(-42)
            make.width.equalTo(170)
            make.height.equalTo(100)
        }

        gripView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-42)
            make.left.equalTo(yearsPlayedView.snp.left)
            make.width.equalTo(170)
            make.height.equalTo(100)
        }

        backhandView.snp.makeConstraints { make in
            make.bottom.equalTo(gripView.snp.bottom)
            make.centerX.equalToSuperview()
            make.width.equalTo(170)
            make.height.equalTo(100)
        }

        pointsView.snp.makeConstraints { make in
            make.bottom.equalTo(gripView.snp.bottom)
            make.right.equalTo(widthView.snp.right)
            make.width.equalTo(170)
            make.height.equalTo(100)
        }

        yearsPlayedView.setupUI()
        heightView.setupUI()
        widthView.setupUI()
        gripView.setupUI()
        backhandView.setupUI()
        pointsView.setupUI()
    }

    func setupEvent() {
        let yearPlayedConfig = TMInfoViewConfig(infoContent: "\(TMUser.user.yearsPlayed)", infoContentFont: 20, infoTitle: NSLocalizedString("YearsPlayed", comment: ""), infoTitleFont: 17, inset: 24)
        let heightConfig = TMInfoViewConfig(infoContent: "\(TMUser.user.height)", infoContentFont: 20, infoTitle: NSLocalizedString("Height", comment: ""), infoTitleFont: 17, inset: 24)
        let widthConfig = TMInfoViewConfig(infoContent: "\(TMUser.user.width)", infoContentFont: 20, infoTitle: NSLocalizedString("Width", comment: ""), infoTitleFont: 17, inset: 24)
        let gripConfig = TMInfoViewConfig(infoContent: NSLocalizedString(TMUser.user.grip.rawValue, comment: ""), infoContentFont: 20, infoTitle: NSLocalizedString("Grip", comment: ""), infoTitleFont: 17, inset: 24)
        let backhandConfig = TMInfoViewConfig(infoContent: NSLocalizedString(TMUser.user.backhand.rawValue, comment: ""), infoContentFont: 17, infoTitle: NSLocalizedString("Backhand", comment: ""), infoTitleFont: 17, inset: 24)
        let pointsConfig = TMInfoViewConfig(infoContent: "\(TMUser.user.points)", infoContentFont: 20, infoTitle: NSLocalizedString("Current Points", comment: ""), infoTitleFont: 17, inset: 24)

        yearsPlayedView.setupEvent(config: yearPlayedConfig)
        heightView.setupEvent(config: heightConfig)
        widthView.setupEvent(config: widthConfig)
        gripView.setupEvent(config: gripConfig)
        backhandView.setupEvent(config: backhandConfig)
        pointsView.setupEvent(config: pointsConfig)
    }
}
