//
//  TMUserStatsView.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/3/10.
//

import Foundation
import JXSegmentedView
import TMComponent
import UIKit

class TMUserStatsView: UIView {
    lazy var backgroundView: UIView = {
        let view = UIView()
        return view
    }()

    lazy var serveLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var returnLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var aceView: TMInfoView = {
        let circleStatsView = TMInfoView()
        return circleStatsView
    }()

    lazy var doubleFaultView: TMInfoView = {
        let circleStatsView = TMInfoView()
        return circleStatsView
    }()

    lazy var returnAceView: TMInfoView = {
        let circleStatsView = TMInfoView()
        return circleStatsView
    }()

    lazy var firstServeInView: TMCircleStatsView = {
        let circleStatsView = TMCircleStatsView()
        return circleStatsView
    }()

    lazy var firstServeWonView: TMCircleStatsView = {
        let circleStatsView = TMCircleStatsView()
        return circleStatsView
    }()

    lazy var secondServeInView: TMCircleStatsView = {
        let circleStatsView = TMCircleStatsView()
        return circleStatsView
    }()

    lazy var secondServeWonView: TMCircleStatsView = {
        let circleStatsView = TMCircleStatsView()
        return circleStatsView
    }()

    lazy var returnFirstServeInView: TMCircleStatsView = {
        let circleStatsView = TMCircleStatsView()
        return circleStatsView
    }()

    lazy var returnFirstServeWonView: TMCircleStatsView = {
        let circleStatsView = TMCircleStatsView()
        return circleStatsView
    }()

    lazy var returnSecondServeInView: TMCircleStatsView = {
        let circleStatsView = TMCircleStatsView()
        return circleStatsView
    }()

    lazy var returnSecondServeWonView: TMCircleStatsView = {
        let circleStatsView = TMCircleStatsView()
        return circleStatsView
    }()

    lazy var breakPointSavedView: TMCircleStatsView = {
        let infoView = TMCircleStatsView()
        return infoView
    }()

    lazy var breakPointConvertedView: TMCircleStatsView = {
        let infoView = TMCircleStatsView()
        return infoView
    }()

    lazy var serveGameWonView: TMCircleStatsView = {
        let infoView = TMCircleStatsView()
        return infoView
    }()

    lazy var returnServeGameWonView: TMCircleStatsView = {
        let infoView = TMCircleStatsView()
        return infoView
    }()

    lazy var servePointWonView: TMCircleStatsView = {
        let infoView = TMCircleStatsView()
        return infoView
    }()

    lazy var returnServePointWonView: TMCircleStatsView = {
        let infoView = TMCircleStatsView()
        return infoView
    }()

    lazy var netPointView: TMInfoView = {
        let infoView = TMInfoView()
        return infoView
    }()

    lazy var ueView: TMInfoView = {
        let infoView = TMInfoView()
        return infoView
    }()

    lazy var forehandWinnerView: TMInfoView = {
        let infoView = TMInfoView()
        return infoView
    }()

    lazy var backhandWinnerView: TMInfoView = {
        let infoView = TMInfoView()
        return infoView
    }()

    func setupUI() {
        addSubview(backgroundView)
        backgroundView.addSubview(serveLabel)
        backgroundView.addSubview(returnLabel)
        backgroundView.addSubview(aceView)
        backgroundView.addSubview(returnAceView)
        backgroundView.addSubview(doubleFaultView)
        backgroundView.addSubview(firstServeInView)
        backgroundView.addSubview(firstServeWonView)
        backgroundView.addSubview(secondServeInView)
        backgroundView.addSubview(secondServeWonView)
        backgroundView.addSubview(returnFirstServeInView)
        backgroundView.addSubview(returnFirstServeWonView)
        backgroundView.addSubview(returnSecondServeInView)
        backgroundView.addSubview(returnSecondServeWonView)
        backgroundView.addSubview(breakPointSavedView)
        backgroundView.addSubview(breakPointConvertedView)
        backgroundView.addSubview(serveGameWonView)
        backgroundView.addSubview(returnServeGameWonView)
        backgroundView.addSubview(servePointWonView)
        backgroundView.addSubview(returnServePointWonView)
        backgroundView.addSubview(netPointView)
        backgroundView.addSubview(ueView)
        backgroundView.addSubview(forehandWinnerView)
        backgroundView.addSubview(backhandWinnerView)

        if UIScreen.main.nativeBounds.height < 2360 {
            backgroundView.snp.makeConstraints { make in
                make.center.equalToSuperview()
                make.width.equalToSuperview()
                make.height.equalTo(248.5)
            }

            serveLabel.snp.makeConstraints { make in
                make.left.equalToSuperview()
                make.top.equalToSuperview().offset(8)
            }
            returnLabel.snp.makeConstraints { make in
                make.right.equalToSuperview()
                make.top.equalToSuperview().offset(8)
            }
            aceView.snp.makeConstraints { make in
                make.top.equalTo(serveLabel.snp.top).offset(-8)
                make.right.equalTo(doubleFaultView.snp.left).offset(-44)
                make.width.equalTo(68)
                make.height.equalTo(38)
            }
            returnAceView.snp.makeConstraints { make in
                make.left.equalTo(doubleFaultView.snp.right).offset(44)
                make.top.equalTo(returnLabel.snp.top).offset(-8)
                make.width.equalTo(68)
                make.height.equalTo(38)
            }
            doubleFaultView.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(serveLabel.snp.top).offset(-8)
                make.width.equalTo(68)
                make.height.equalTo(38)
            }

            firstServeInView.snp.makeConstraints { make in
                make.top.equalTo(serveLabel.snp.bottom).offset(24)
                make.left.equalTo(serveLabel.snp.left)
                make.height.equalTo(92)
                make.width.equalTo(110)
            }

            firstServeWonView.snp.makeConstraints { make in
                make.top.equalTo(firstServeInView.snp.top)
                make.left.equalTo(firstServeInView.snp.right).offset(8)
                make.height.equalTo(92)
                make.width.equalTo(110)
            }
            secondServeInView.snp.makeConstraints { make in
                make.top.equalTo(firstServeInView.snp.top)
                make.left.equalTo(firstServeWonView.snp.right).offset(8)
                make.height.equalTo(92)
                make.width.equalTo(110)
            }
            secondServeWonView.snp.makeConstraints { make in
                make.top.equalTo(firstServeInView.snp.top)
                make.left.equalTo(secondServeInView.snp.right).offset(8)
                make.height.equalTo(92)
                make.width.equalTo(110)
            }
            breakPointSavedView.snp.makeConstraints { make in
                make.top.equalTo(firstServeInView.snp.bottom).offset(12)
                make.left.equalTo(firstServeInView.snp.left)
                make.height.equalTo(92)
                make.width.equalTo(110)
            }
            serveGameWonView.snp.makeConstraints { make in
                make.top.equalTo(breakPointSavedView.snp.top)
                make.left.equalTo(breakPointSavedView.snp.right).offset(8)
                make.height.equalTo(92)
                make.width.equalTo(110)
            }
            servePointWonView.snp.makeConstraints { make in
                make.top.equalTo(breakPointSavedView.snp.top)
                make.left.equalTo(serveGameWonView.snp.right).offset(8)
                make.height.equalTo(92)
                make.width.equalTo(110)
            }

            returnFirstServeInView.snp.makeConstraints { make in
                make.top.equalTo(returnLabel.snp.bottom).offset(24)
                make.right.equalTo(returnLabel.snp.right)
                make.height.equalTo(92)
                make.width.equalTo(110)
            }
            returnFirstServeWonView.snp.makeConstraints { make in
                make.top.equalTo(returnFirstServeInView.snp.top)
                make.right.equalTo(returnFirstServeInView.snp.left).offset(-8)
                make.height.equalTo(92)
                make.width.equalTo(110)
            }
            returnSecondServeInView.snp.makeConstraints { make in
                make.top.equalTo(returnFirstServeInView.snp.top)
                make.right.equalTo(returnFirstServeWonView.snp.left).offset(-8)
                make.height.equalTo(92)
                make.width.equalTo(110)
            }
            returnSecondServeWonView.snp.makeConstraints { make in
                make.top.equalTo(returnFirstServeInView.snp.top)
                make.right.equalTo(returnSecondServeInView.snp.left).offset(-8)
                make.height.equalTo(92)
                make.width.equalTo(110)
            }
            breakPointConvertedView.snp.makeConstraints { make in
                make.top.equalTo(returnFirstServeInView.snp.bottom).offset(12)
                make.right.equalTo(returnFirstServeInView.snp.right)
                make.height.equalTo(92)
                make.width.equalTo(110)
            }
            returnServeGameWonView.snp.makeConstraints { make in
                make.top.equalTo(breakPointConvertedView.snp.top)
                make.right.equalTo(breakPointConvertedView.snp.left).offset(-8)
                make.height.equalTo(92)
                make.width.equalTo(110)
            }
            returnServePointWonView.snp.makeConstraints { make in
                make.top.equalTo(breakPointConvertedView.snp.top)
                make.right.equalTo(returnServeGameWonView.snp.left).offset(-8)
                make.height.equalTo(92)
                make.width.equalTo(110)
            }

            netPointView.snp.makeConstraints { make in
                make.top.equalTo(servePointWonView.snp.top)
                make.left.equalTo(servePointWonView.snp.right).offset(8)
                make.width.equalTo(110)
                make.height.equalTo(servePointWonView.snp.height).dividedBy(2).offset(-1)
            }

            ueView.snp.makeConstraints { make in
                make.top.equalTo(returnServePointWonView.snp.top)
                make.right.equalTo(returnServePointWonView.snp.left).offset(-8)
                make.width.equalTo(110)
                make.height.equalTo(returnServePointWonView.snp.height).dividedBy(2).offset(-1)
            }

            forehandWinnerView.snp.makeConstraints { make in
                make.top.equalTo(netPointView.snp.bottom).offset(2)
                make.left.equalTo(servePointWonView.snp.right).offset(8)
                make.width.equalTo(110)
                make.height.equalTo(servePointWonView.snp.height).dividedBy(2).offset(-1)
            }
            backhandWinnerView.snp.makeConstraints { make in
                make.top.equalTo(ueView.snp.bottom).offset(2)
                make.right.equalTo(returnServePointWonView.snp.left).offset(-8)
                make.width.equalTo(110)
                make.height.equalTo(returnServePointWonView.snp.height).dividedBy(2).offset(-1)
            }

        } else {
            backgroundView.snp.makeConstraints { make in
                make.center.equalToSuperview()
                make.width.equalToSuperview()
                make.height.equalTo(294.5)
            }

            serveLabel.snp.makeConstraints { make in
                make.left.equalToSuperview()
                make.top.equalToSuperview().offset(18)
            }
            returnLabel.snp.makeConstraints { make in
                make.right.equalToSuperview()
                make.top.equalToSuperview().offset(18)
            }
            aceView.snp.makeConstraints { make in
                make.top.equalTo(serveLabel.snp.top).offset(-18)
                make.right.equalTo(doubleFaultView.snp.left).offset(-44)
                make.width.equalTo(100)
                make.height.equalTo(48)
            }
            returnAceView.snp.makeConstraints { make in
                make.left.equalTo(doubleFaultView.snp.right).offset(44)
                make.top.equalTo(returnLabel.snp.top).offset(-18)
                make.width.equalTo(100)
                make.height.equalTo(48)
            }
            doubleFaultView.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(serveLabel.snp.top).offset(-18)
                make.width.equalTo(100)
                make.height.equalTo(48)
            }

            firstServeInView.snp.makeConstraints { make in
                make.top.equalTo(serveLabel.snp.bottom).offset(24)
                make.left.equalTo(serveLabel.snp.left)
                make.height.equalTo(110)
                make.width.equalTo(130)
            }

            firstServeWonView.snp.makeConstraints { make in
                make.top.equalTo(firstServeInView.snp.top)
                make.left.equalTo(firstServeInView.snp.right).offset(8)
                make.height.equalTo(110)
                make.width.equalTo(130)
            }
            secondServeInView.snp.makeConstraints { make in
                make.top.equalTo(firstServeInView.snp.top)
                make.left.equalTo(firstServeWonView.snp.right).offset(8)
                make.height.equalTo(110)
                make.width.equalTo(130)
            }
            secondServeWonView.snp.makeConstraints { make in
                make.top.equalTo(firstServeInView.snp.top)
                make.left.equalTo(secondServeInView.snp.right).offset(8)
                make.height.equalTo(110)
                make.width.equalTo(130)
            }
            breakPointSavedView.snp.makeConstraints { make in
                make.top.equalTo(firstServeInView.snp.bottom).offset(12)
                make.left.equalTo(firstServeInView.snp.left)
                make.height.equalTo(110)
                make.width.equalTo(130)
            }
            serveGameWonView.snp.makeConstraints { make in
                make.top.equalTo(breakPointSavedView.snp.top)
                make.left.equalTo(breakPointSavedView.snp.right).offset(8)
                make.height.equalTo(110)
                make.width.equalTo(130)
            }
            servePointWonView.snp.makeConstraints { make in
                make.top.equalTo(breakPointSavedView.snp.top)
                make.left.equalTo(serveGameWonView.snp.right).offset(8)
                make.height.equalTo(110)
                make.width.equalTo(130)
            }

            returnFirstServeInView.snp.makeConstraints { make in
                make.top.equalTo(returnLabel.snp.bottom).offset(24)
                make.right.equalTo(returnLabel.snp.right)
                make.height.equalTo(110)
                make.width.equalTo(130)
            }
            returnFirstServeWonView.snp.makeConstraints { make in
                make.top.equalTo(returnFirstServeInView.snp.top)
                make.right.equalTo(returnFirstServeInView.snp.left).offset(-8)
                make.height.equalTo(110)
                make.width.equalTo(130)
            }
            returnSecondServeInView.snp.makeConstraints { make in
                make.top.equalTo(returnFirstServeInView.snp.top)
                make.right.equalTo(returnFirstServeWonView.snp.left).offset(-8)
                make.height.equalTo(110)
                make.width.equalTo(130)
            }
            returnSecondServeWonView.snp.makeConstraints { make in
                make.top.equalTo(returnFirstServeInView.snp.top)
                make.right.equalTo(returnSecondServeInView.snp.left).offset(-8)
                make.height.equalTo(110)
                make.width.equalTo(130)
            }
            breakPointConvertedView.snp.makeConstraints { make in
                make.top.equalTo(returnFirstServeInView.snp.bottom).offset(12)
                make.right.equalTo(returnFirstServeInView.snp.right)
                make.height.equalTo(110)
                make.width.equalTo(130)
            }
            returnServeGameWonView.snp.makeConstraints { make in
                make.top.equalTo(breakPointConvertedView.snp.top)
                make.right.equalTo(breakPointConvertedView.snp.left).offset(-8)
                make.height.equalTo(110)
                make.width.equalTo(130)
            }
            returnServePointWonView.snp.makeConstraints { make in
                make.top.equalTo(breakPointConvertedView.snp.top)
                make.right.equalTo(returnServeGameWonView.snp.left).offset(-8)
                make.height.equalTo(110)
                make.width.equalTo(130)
            }

            netPointView.snp.makeConstraints { make in
                make.top.equalTo(servePointWonView.snp.top)
                make.left.equalTo(servePointWonView.snp.right).offset(8)
                make.width.equalTo(130)
                make.height.equalTo(servePointWonView.snp.height).dividedBy(2).offset(-1)
            }

            ueView.snp.makeConstraints { make in
                make.top.equalTo(returnServePointWonView.snp.top)
                make.right.equalTo(returnServePointWonView.snp.left).offset(-8)
                make.width.equalTo(130)
                make.height.equalTo(returnServePointWonView.snp.height).dividedBy(2).offset(-1)
            }

            forehandWinnerView.snp.makeConstraints { make in
                make.top.equalTo(netPointView.snp.bottom).offset(2)
                make.left.equalTo(servePointWonView.snp.right).offset(8)
                make.width.equalTo(130)
                make.height.equalTo(servePointWonView.snp.height).dividedBy(2).offset(-1)
            }
            backhandWinnerView.snp.makeConstraints { make in
                make.top.equalTo(ueView.snp.bottom).offset(2)
                make.right.equalTo(returnServePointWonView.snp.left).offset(-8)
                make.width.equalTo(130)
                make.height.equalTo(returnServePointWonView.snp.height).dividedBy(2).offset(-1)
            }
        }

        aceView.setCorner(radii: 15)
        returnAceView.setCorner(radii: 15)
        doubleFaultView.setCorner(radii: 15)
        netPointView.setCorner(radii: 15)
        ueView.setCorner(radii: 15)
        forehandWinnerView.setCorner(radii: 15)
        backhandWinnerView.setCorner(radii: 15)

        aceView.backgroundColor = .white
        returnAceView.backgroundColor = .white
        doubleFaultView.backgroundColor = .white
        netPointView.backgroundColor = .white
        ueView.backgroundColor = .white
        forehandWinnerView.backgroundColor = .white
        backhandWinnerView.backgroundColor = .white

        serveLabel.text = NSLocalizedString("SERVE", comment: "")
        returnLabel.text = NSLocalizedString("RETURN", comment: "")

        aceView.setupUI()
        returnAceView.setupUI()
        doubleFaultView.setupUI()
        netPointView.setupUI()
        ueView.setupUI()
        forehandWinnerView.setupUI()
        backhandWinnerView.setupUI()

        if UIScreen.main.nativeBounds.height < 2360 {
            firstServeInView.setUpUI(sideLen: 40, insight: 4, title: NSLocalizedString("1ST SERVE IN", comment: ""))
            firstServeWonView.setUpUI(sideLen: 40, insight: 4, title: NSLocalizedString("1ST SERVE WON", comment: ""))
            secondServeInView.setUpUI(sideLen: 40, insight: 4, title: NSLocalizedString("2ND SERVE IN", comment: ""))
            secondServeWonView.setUpUI(sideLen: 40, insight: 4, title: NSLocalizedString("2ND SERVE WON", comment: ""))
            returnFirstServeInView.setUpUI(sideLen: 40, insight: 4, title: NSLocalizedString("1ST RETURN IN", comment: ""))
            returnFirstServeWonView.setUpUI(sideLen: 40, insight: 4, title: NSLocalizedString("1ST RETURN WON", comment: ""))
            returnSecondServeInView.setUpUI(sideLen: 40, insight: 4, title: NSLocalizedString("2ND RETURN IN", comment: ""))
            returnSecondServeWonView.setUpUI(sideLen: 40, insight: 4, title: NSLocalizedString("2ND RETURN WON", comment: ""))
            breakPointSavedView.setUpUI(sideLen: 40, insight: 4, title: NSLocalizedString("BREAK POINT SAVED", comment: ""))
            breakPointConvertedView.setUpUI(sideLen: 40, insight: 4, title: NSLocalizedString("BREAK POINT CONVERT", comment: ""))
            serveGameWonView.setUpUI(sideLen: 40, insight: 4, title: NSLocalizedString("SERVE GAME WON", comment: ""))
            returnServeGameWonView.setUpUI(sideLen: 40, insight: 4, title: NSLocalizedString("RETURN GAME WON", comment: ""))
            servePointWonView.setUpUI(sideLen: 40, insight: 4, title: NSLocalizedString("SERVE POINT WON", comment: ""))
            returnServePointWonView.setUpUI(sideLen: 40, insight: 4, title: NSLocalizedString("RETURN POINT WON", comment: ""))
        } else {
            firstServeInView.setUpUI(sideLen: 50, insight: 12, title: NSLocalizedString("1ST SERVE IN", comment: ""))
            firstServeWonView.setUpUI(sideLen: 50, insight: 12, title: NSLocalizedString("1ST SERVE WON", comment: ""))
            secondServeInView.setUpUI(sideLen: 50, insight: 12, title: NSLocalizedString("2ND SERVE IN", comment: ""))
            secondServeWonView.setUpUI(sideLen: 50, insight: 12, title: NSLocalizedString("2ND SERVE WON", comment: ""))
            returnFirstServeInView.setUpUI(sideLen: 50, insight: 12, title: NSLocalizedString("1ST RETURN IN", comment: ""))
            returnFirstServeWonView.setUpUI(sideLen: 50, insight: 12, title: NSLocalizedString("1ST RETURN WON", comment: ""))
            returnSecondServeInView.setUpUI(sideLen: 50, insight: 12, title: NSLocalizedString("2ND RETURN IN", comment: ""))
            returnSecondServeWonView.setUpUI(sideLen: 50, insight: 12, title: NSLocalizedString("2ND RETURN WON", comment: ""))
            breakPointSavedView.setUpUI(sideLen: 50, insight: 12, title: NSLocalizedString("BREAK POINT SAVED", comment: ""))
            breakPointConvertedView.setUpUI(sideLen: 50, insight: 12, title: NSLocalizedString("BREAK POINT CONVERT", comment: ""))
            serveGameWonView.setUpUI(sideLen: 50, insight: 12, title: NSLocalizedString("SERVE GAME WON", comment: ""))
            returnServeGameWonView.setUpUI(sideLen: 50, insight: 12, title: NSLocalizedString("RETURN GAME WON", comment: ""))
            servePointWonView.setUpUI(sideLen: 50, insight: 12, title: NSLocalizedString("SERVE POINT WON", comment: ""))
            returnServePointWonView.setUpUI(sideLen: 50, insight: 12, title: NSLocalizedString("RETURN POINT WON", comment: ""))
        }
    }

    func setupEvent(stats: Stats) {
        let firstServeIn = stats.convertToRealStats().firstServeIn
        let firstServeWon = stats.convertToRealStats().firstServeWon
        let secondServeIn = stats.convertToRealStats().secondServeIn
        let secondServeWon = stats.convertToRealStats().secondServeWon
        let firstReturnServeIn = stats.convertToRealStats().firstReturnServeIn
        let firstReturnServeWon = stats.convertToRealStats().firstReturnServeWon
        let secondReturnServeIn = stats.convertToRealStats().secondReturnServeIn
        let secondReturnServeWon = stats.convertToRealStats().secondReturnServeWon
        let breakPointSaved = stats.convertToRealStats().breakPointSaved
        let breakPointConvert = stats.convertToRealStats().breakPointConvert
        let serveGameWon = stats.convertToRealStats().serveGameWon
        let returnGameWon = stats.convertToRealStats().returnGameWon
        let servePointWon = stats.convertToRealStats().servePointWon
        let returnPointWon = stats.convertToRealStats().returnPointWon

        firstServeInView.startAnimation(radii: firstServeIn)
        firstServeWonView.startAnimation(radii: firstServeWon)
        secondServeInView.startAnimation(radii: secondServeIn)
        secondServeWonView.startAnimation(radii: secondServeWon)
        returnFirstServeInView.startAnimation(radii: firstReturnServeIn)
        returnFirstServeWonView.startAnimation(radii: firstReturnServeWon)
        returnSecondServeInView.startAnimation(radii: secondReturnServeIn)
        returnSecondServeWonView.startAnimation(radii: secondReturnServeWon)
        breakPointSavedView.startAnimation(radii: breakPointSaved)
        breakPointConvertedView.startAnimation(radii: breakPointConvert)
        serveGameWonView.startAnimation(radii: serveGameWon)
        returnServeGameWonView.startAnimation(radii: returnGameWon)
        servePointWonView.startAnimation(radii: servePointWon)
        returnServePointWonView.startAnimation(radii: returnPointWon)

        if UIScreen.main.nativeBounds.height < 2360 {
            let aceConfig = TMInfoViewConfig(infoContent: "\(stats.aces)", infoContentFont: 10, infoTitle: NSLocalizedString("ACES", comment: ""), infoTitleFont: 8, inset: 6)
            let returnAceConfig = TMInfoViewConfig(infoContent: "\(stats.returnAces)", infoContentFont: 10, infoTitle: NSLocalizedString("RETURN ACES", comment: ""), infoTitleFont: 8, inset: 6)
            let doubleFaultConfig = TMInfoViewConfig(infoContent: "\(stats.doubleFaults)", infoContentFont: 10, infoTitle: NSLocalizedString("DOUBLE FAULTS", comment: ""), infoTitleFont: 8, inset: 6)
            let netPointConfig = TMInfoViewConfig(infoContent: "\(stats.netPoints)", infoContentFont: 10, infoTitle: NSLocalizedString("NET POINTS", comment: ""), infoTitleFont: 8, inset: 6)
            let ueConfig = TMInfoViewConfig(infoContent: "\(stats.unforcedErrors)", infoContentFont: 10, infoTitle: NSLocalizedString("UNFORCED ERRORS", comment: ""), infoTitleFont: 8, inset: 6)
            let forehandWinnerConfig = TMInfoViewConfig(infoContent: "\(stats.forehandWinners)", infoContentFont: 10, infoTitle: NSLocalizedString("FOREHAND WINNERS", comment: ""), infoTitleFont: 8, inset: 6)
            let backhandWinnerConfig = TMInfoViewConfig(infoContent: "\(stats.backhandWinners)", infoContentFont: 10, infoTitle: NSLocalizedString("BACKHAND WINNERS", comment: ""), infoTitleFont: 8, inset: 6)

            aceView.setupEvent(config: aceConfig)
            returnAceView.setupEvent(config: returnAceConfig)
            doubleFaultView.setupEvent(config: doubleFaultConfig)
            netPointView.setupEvent(config: netPointConfig)
            ueView.setupEvent(config: ueConfig)
            forehandWinnerView.setupEvent(config: forehandWinnerConfig)
            backhandWinnerView.setupEvent(config: backhandWinnerConfig)
        } else {
            let aceConfig = TMInfoViewConfig(infoContent: "\(stats.aces)", infoContentFont: 10, infoTitle: NSLocalizedString("ACES", comment: ""), infoTitleFont: 8, inset: 6)
            let returnAceConfig = TMInfoViewConfig(infoContent: "\(stats.returnAces)", infoContentFont: 10, infoTitle: NSLocalizedString("RETURN ACES", comment: ""), infoTitleFont: 8, inset: 6)
            let doubleFaultConfig = TMInfoViewConfig(infoContent: "\(stats.doubleFaults)", infoContentFont: 10, infoTitle: NSLocalizedString("DOUBLE FAULTS", comment: ""), infoTitleFont: 8, inset: 6)
            let netPointConfig = TMInfoViewConfig(infoContent: "\(stats.netPoints)", infoContentFont: 10, infoTitle: NSLocalizedString("NET POINTS", comment: ""), infoTitleFont: 8, inset: 6)
            let ueConfig = TMInfoViewConfig(infoContent: "\(stats.unforcedErrors)", infoContentFont: 10, infoTitle: NSLocalizedString("UNFORCED ERRORS", comment: ""), infoTitleFont: 8, inset: 6)
            let forehandWinnerConfig = TMInfoViewConfig(infoContent: "\(stats.forehandWinners)", infoContentFont: 10, infoTitle: NSLocalizedString("FOREHAND WINNERS", comment: ""), infoTitleFont: 8, inset: 6)
            let backhandWinnerConfig = TMInfoViewConfig(infoContent: "\(stats.backhandWinners)", infoContentFont: 10, infoTitle: NSLocalizedString("BACKHAND WINNERS", comment: ""), infoTitleFont: 8, inset: 6)

            aceView.setupEvent(config: aceConfig)
            returnAceView.setupEvent(config: returnAceConfig)
            doubleFaultView.setupEvent(config: doubleFaultConfig)
            netPointView.setupEvent(config: netPointConfig)
            ueView.setupEvent(config: ueConfig)
            forehandWinnerView.setupEvent(config: forehandWinnerConfig)
            backhandWinnerView.setupEvent(config: backhandWinnerConfig)
        }
    }
}

extension TMUserStatsView: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return self
    }
}
