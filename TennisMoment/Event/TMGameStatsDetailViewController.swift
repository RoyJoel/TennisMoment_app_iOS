//
//  TMGameStatsDetailViewController.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/3/26.
//

import Foundation
import TMComponent
import UIKit

class TMGameStatsDetailViewController: UIViewController {
    var game: Game = Game()
    var games: [Game] = []

    lazy var player1IconView: TMIconView = {
        let iconView = TMIconView()
        return iconView
    }()

    lazy var player2IconView: TMIconView = {
        let iconView = TMIconView()
        return iconView
    }()

    lazy var player1RankingLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var player2RankingLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var H2HRecordView: TMPointComparingView = {
        let view = TMPointComparingView()
        return view
    }()

    lazy var progressView: UIProgressView = {
        let view = UIProgressView()
        view.progressViewStyle = .default
        return view
    }()

    lazy var resultView: TMmultiplyConfigurableView = {
        let view = TMmultiplyConfigurableView()
        return view
    }()

    lazy var resultLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var resultBackgroundView: UIView = {
        let view = UIView()
        return view
    }()

    lazy var timeLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var placeLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var eventLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var roundLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var serveStatsBackgroundView: UIView = {
        let view = UIView()
        return view
    }()

    lazy var returnStatsBackgroundView: UIView = {
        let view = UIView()
        return view
    }()

    lazy var serveStatsLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var returnStatsLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var serveStatsView: TMmultiplyConfigurableView = {
        let view = TMmultiplyConfigurableView()
        return view
    }()

    lazy var returnStatsView: TMmultiplyConfigurableView = {
        let view = TMmultiplyConfigurableView()
        return view
    }()

    lazy var commonStatsBackgroundView: UIView = {
        let view = UIView()
        return view
    }()

    lazy var commonStatsLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var commonStatsView: TMmultiplyConfigurableView = {
        let view = TMmultiplyConfigurableView()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "BackgroundGray")
        view.addSubview(player1IconView)
        view.addSubview(player2IconView)
        view.addSubview(player1RankingLabel)
        view.addSubview(player2RankingLabel)
        view.addSubview(H2HRecordView)
        view.insertSubview(progressView, belowSubview: H2HRecordView)
        view.addSubview(resultBackgroundView)
        resultBackgroundView.addSubview(resultView)
        resultBackgroundView.addSubview(resultLabel)
        view.addSubview(commonStatsBackgroundView)
        commonStatsBackgroundView.addSubview(commonStatsLabel)
        commonStatsBackgroundView.addSubview(commonStatsView)
        view.addSubview(timeLabel)
        view.addSubview(placeLabel)
        view.addSubview(eventLabel)
        view.addSubview(roundLabel)
        view.addSubview(serveStatsBackgroundView)
        view.addSubview(returnStatsBackgroundView)
        serveStatsBackgroundView.addSubview(serveStatsLabel)
        returnStatsBackgroundView.addSubview(returnStatsLabel)
        serveStatsBackgroundView.addSubview(serveStatsView)
        returnStatsBackgroundView.addSubview(returnStatsView)

        player1IconView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(68)
            make.left.equalToSuperview().offset(24)
            make.width.equalTo(138)
            make.height.equalTo(188)
        }
        player2IconView.snp.makeConstraints { make in
            make.top.equalTo(player1IconView.snp.top)
            make.right.equalTo(commonStatsBackgroundView.snp.right)
            make.width.equalTo(138)
            make.height.equalTo(188)
        }
        player1RankingLabel.snp.makeConstraints { make in
            make.top.equalTo(player1IconView.snp.bottom).offset(6)
            make.left.equalTo(player1IconView.snp.left)
            make.width.equalTo(player1IconView.snp.width)
            make.height.equalTo(22)
        }
        player2RankingLabel.snp.makeConstraints { make in
            make.top.equalTo(player1RankingLabel.snp.top)
            make.left.equalTo(player2IconView.snp.left)
            make.width.equalTo(player2IconView.snp.width)
            make.height.equalTo(22)
        }
        H2HRecordView.snp.makeConstraints { make in
            make.centerY.equalTo(player1IconView.snp.centerY)
            make.left.equalTo(player1IconView.snp.right).offset(6)
            make.right.equalTo(player2IconView.snp.left).offset(-6)
            make.height.equalTo(40)
        }
        progressView.snp.makeConstraints { make in
            make.edges.equalTo(H2HRecordView.snp.edges)
        }
        resultBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(roundLabel.snp.bottom).offset(12)
            make.width.equalTo(188)
            make.left.equalTo(timeLabel.snp.left)
            make.bottom.equalToSuperview().offset(-98)
        }
        resultLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.left.equalToSuperview().offset(12)
            make.width.equalTo(88)
            make.height.equalTo(25)
        }
        resultView.snp.makeConstraints { make in
            make.top.equalTo(resultLabel.snp.bottom).offset(12)
            make.bottom.equalToSuperview().offset(-12)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
        }
        commonStatsBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.top)
            make.width.equalTo(218)
            make.left.equalTo(resultBackgroundView.snp.right).offset(12)
            make.bottom.equalTo(resultBackgroundView.snp.bottom)
        }
        commonStatsLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.left.equalToSuperview().offset(12)
            make.width.equalTo(112)
            make.height.equalTo(25)
        }
        commonStatsView.snp.makeConstraints { make in
            make.top.equalTo(commonStatsLabel.snp.bottom).offset(12)
            make.bottom.equalToSuperview().offset(-12)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
        }
        timeLabel.snp.makeConstraints { make in
            make.left.equalTo(player1IconView.snp.left)
            make.top.equalTo(player1RankingLabel.snp.bottom).offset(12)
            make.width.equalTo(158)
            make.height.equalTo(22)
        }
        placeLabel.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(6)
            make.left.equalTo(timeLabel.snp.left)
            make.width.equalTo(158)
            make.height.equalTo(22)
        }
        eventLabel.snp.makeConstraints { make in
            make.top.equalTo(placeLabel.snp.bottom).offset(6)
            make.left.equalTo(timeLabel.snp.left)
            make.width.equalTo(324)
            make.height.equalTo(22)
        }
        roundLabel.snp.makeConstraints { make in
            make.top.equalTo(eventLabel.snp.bottom).offset(6)
            make.left.equalTo(timeLabel.snp.left)
            make.width.equalTo(324)
            make.height.equalTo(22)
        }
        serveStatsBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(player1IconView.snp.top).offset(12)
            make.right.equalTo(returnStatsBackgroundView.snp.left).offset(-12)
            make.width.equalTo(324)
            make.bottom.equalToSuperview().offset(-98)
        }
        returnStatsBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(player1IconView.snp.top).offset(12)
            make.right.equalToSuperview().offset(-24)
            make.width.equalTo(324)
            make.bottom.equalToSuperview().offset(-98)
        }
        serveStatsLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.centerX.equalToSuperview()
            make.width.equalTo(324)
            make.height.equalTo(25)
        }
        serveStatsView.snp.makeConstraints { make in
            make.top.equalTo(serveStatsLabel.snp.bottom).offset(6)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(12)
            make.width.equalTo(300)
        }
        returnStatsLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(25)
        }
        returnStatsView.snp.makeConstraints { make in
            make.top.equalTo(returnStatsLabel.snp.bottom).offset(6)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(12)
            make.width.equalTo(300)
        }

        let h2hRecordConfig = TMPointComparingViewConfig(isTitleViewAbovePointView: false, isTitleHidden: false, title: "H2H", isServingOnLeft: false, areBothServing: false, isComparing: false, font: UIFont.systemFont(ofSize: 17), leftNum: "\(0)", rightNum: "\(0)")
        H2HRecordView.setup(with: h2hRecordConfig)
        progressView.setCorner(radii: 10)
        H2HRecordView.setCorner(radii: 10)
        H2HRecordView.addTapGesture(self, #selector(presentH2HView))
        resultBackgroundView.backgroundColor = UIColor(named: "ComponentBackground")
        commonStatsBackgroundView.backgroundColor = UIColor(named: "ComponentBackground")
        serveStatsBackgroundView.backgroundColor = UIColor(named: "ComponentBackground")
        returnStatsBackgroundView.backgroundColor = UIColor(named: "ComponentBackground")
        resultBackgroundView.setCorner(radii: 15)
        commonStatsBackgroundView.setCorner(radii: 15)
        serveStatsBackgroundView.setCorner(radii: 15)
        returnStatsBackgroundView.setCorner(radii: 15)
        player1IconView.setupUI()
        player2IconView.setupUI()
        resultView.setupUI()
        commonStatsView.setupUI()
        serveStatsView.setupUI()
        returnStatsView.setupUI()
        resultLabel.text = NSLocalizedString("Result", comment: "")
        commonStatsLabel.text = NSLocalizedString("Stats", comment: "")
        serveStatsLabel.text = NSLocalizedString("Serve Stats", comment: "")
        returnStatsLabel.text = NSLocalizedString("Return Stats", comment: "")
        resultLabel.font = UIFont.systemFont(ofSize: 23)
        commonStatsLabel.font = UIFont.systemFont(ofSize: 23)
        serveStatsLabel.font = UIFont.systemFont(ofSize: 23)
        returnStatsLabel.font = UIFont.systemFont(ofSize: 23)
        player1RankingLabel.textAlignment = .center
        player2RankingLabel.textAlignment = .center
        serveStatsLabel.textAlignment = .center
        returnStatsLabel.textAlignment = .center

        player1IconView.isUserInteractionEnabled = true
        player2IconView.isUserInteractionEnabled = true
        player1IconView.addTapGesture(self, #selector(seePlayerInfo(sender:)))
        player2IconView.addTapGesture(self, #selector(seePlayerInfo(sender:)))

        setupEvent(game: game)
    }

    func setupEvent(game: Game) {
        timeLabel.text = NSLocalizedString("Date", comment: "") + ": \(game.startDate.convertToString(formatterString: "yyyy MM-dd HH:mm"))"
        placeLabel.text = NSLocalizedString("Place", comment: "") + ": \(game.place)"
        eventLabel.text = NSLocalizedString("Event", comment: "") + ": "
        roundLabel.text = NSLocalizedString("Round", comment: "") + ": \(game.round)"
        let player1IconConfig = TMIconViewConfig(icon: game.player1.icon.toPng(), name: game.player1.name)
        let player2IconConfig = TMIconViewConfig(icon: game.player2.icon.toPng(), name: game.player2.name)
        let result = TMDataConvert.gameResult(from: game.result, isGameCompleted: true)
        var multiConfig: [TMPointComparingViewConfig] = []
        for setResult in result.indices {
            let config = TMPointComparingViewConfig(isTitleViewAbovePointView: false, isTitleHidden: false, title: String(format: NSLocalizedString("setResult", comment: ""), setResult + 1), iconName: "checkmark.circle", isServingOnLeft: result[setResult][0] > result[setResult][1] ? true : false, areBothServing: false, isComparing: true, font: UIFont.systemFont(ofSize: 20), leftNum: "\(result[setResult][0])", rightNum: "\(result[setResult][1])")
            multiConfig.append(config)
        }

        let firstServeIn = game.player1Stats.convertToRealStats().firstServeIn
        let firstServeWon = game.player1Stats.convertToRealStats().firstServeWon
        let secondServeIn = game.player1Stats.convertToRealStats().secondServeIn
        let secondServeWon = game.player1Stats.convertToRealStats().secondServeWon
        let firstReturnServeIn = game.player1Stats.convertToRealStats().firstReturnServeIn
        let firstReturnServeWon = game.player1Stats.convertToRealStats().firstReturnServeWon
        let secondReturnServeIn = game.player1Stats.convertToRealStats().secondReturnServeIn
        let secondReturnServeWon = game.player1Stats.convertToRealStats().secondReturnServeWon
        let breakPointSaved = game.player1Stats.convertToRealStats().breakPointSaved
        let breakPointConvert = game.player1Stats.convertToRealStats().breakPointConvert
        let serveGameWon = game.player1Stats.convertToRealStats().serveGameWon
        let returnGameWon = game.player1Stats.convertToRealStats().returnGameWon
        let servePointWon = game.player1Stats.convertToRealStats().servePointWon
        let returnPointWon = game.player1Stats.convertToRealStats().returnPointWon

        let firstServeIn2 = game.player2Stats.convertToRealStats().firstServeIn
        let firstServeWon2 = game.player2Stats.convertToRealStats().firstServeWon
        let secondServeIn2 = game.player2Stats.convertToRealStats().secondServeIn
        let secondServeWon2 = game.player2Stats.convertToRealStats().secondServeWon
        let firstReturnServeIn2 = game.player2Stats.convertToRealStats().firstReturnServeIn
        let firstReturnServeWon2 = game.player2Stats.convertToRealStats().firstReturnServeWon
        let secondReturnServeIn2 = game.player2Stats.convertToRealStats().secondReturnServeIn
        let secondReturnServeWon2 = game.player2Stats.convertToRealStats().secondReturnServeWon
        let breakPointSaved2 = game.player2Stats.convertToRealStats().breakPointSaved
        let breakPointConvert2 = game.player2Stats.convertToRealStats().breakPointConvert
        let serveGameWon2 = game.player2Stats.convertToRealStats().serveGameWon
        let returnGameWon2 = game.player2Stats.convertToRealStats().returnGameWon
        let servePointWon2 = game.player2Stats.convertToRealStats().servePointWon
        let returnPointWon2 = game.player2Stats.convertToRealStats().returnPointWon

        let firstServeInConfig = TMPointComparingViewConfig(isTitleViewAbovePointView: false, isTitleHidden: false, title: NSLocalizedString("1ST Serve In", comment: ""), iconName: "checkmark.circle", isServingOnLeft: firstServeIn > firstServeIn2 ? true : false, areBothServing: false, isComparing: firstServeIn != firstServeIn2 ? true : false, font: UIFont.systemFont(ofSize: 17), leftNum: "\(firstServeIn)%", rightNum: "\(firstServeIn2)%")
        let firstServeWonConfig = TMPointComparingViewConfig(isTitleViewAbovePointView: false, isTitleHidden: false, title: NSLocalizedString("1ST Serve Won", comment: ""), iconName: "checkmark.circle", isServingOnLeft: firstServeWon > firstServeWon2 ? true : false, areBothServing: false, isComparing: firstServeWon != firstServeWon2 ? true : false, font: UIFont.systemFont(ofSize: 17), leftNum: "\(firstServeWon)%", rightNum: "\(firstServeWon2)%")
        let secondServeInConfig = TMPointComparingViewConfig(isTitleViewAbovePointView: false, isTitleHidden: false, title: NSLocalizedString("2ND Serve In", comment: ""), iconName: "checkmark.circle", isServingOnLeft: secondServeIn > secondServeIn2 ? true : false, areBothServing: false, isComparing: secondServeIn != secondServeIn2 ? true : false, font: UIFont.systemFont(ofSize: 17), leftNum: "\(secondServeIn)%", rightNum: "\(secondServeIn2)%")
        let secondServeWonConfig = TMPointComparingViewConfig(isTitleViewAbovePointView: false, isTitleHidden: false, title: NSLocalizedString("2ND Serve Won", comment: ""), iconName: "checkmark.circle", isServingOnLeft: secondServeWon > secondServeWon2 ? true : false, areBothServing: false, isComparing: secondServeWon != secondServeWon2 ? true : false, font: UIFont.systemFont(ofSize: 17), leftNum: "\(secondServeWon)%", rightNum: "\(secondServeWon2)%")
        let breakPointSavedConfig = TMPointComparingViewConfig(isTitleViewAbovePointView: false, isTitleHidden: false, title: NSLocalizedString("Break Point Saved", comment: ""), iconName: "checkmark.circle", isServingOnLeft: breakPointSaved > breakPointSaved2 ? true : false, areBothServing: false, isComparing: breakPointSaved != breakPointSaved2 ? true : false, font: UIFont.systemFont(ofSize: 17), leftNum: "\(breakPointSaved)%", rightNum: "\(breakPointSaved2)%")
        let servePointWonConfig = TMPointComparingViewConfig(isTitleViewAbovePointView: false, isTitleHidden: false, title: NSLocalizedString("Serve Point Won", comment: ""), iconName: "checkmark.circle", isServingOnLeft: servePointWon > servePointWon2 ? true : false, areBothServing: false, isComparing: servePointWon != servePointWon2 ? true : false, font: UIFont.systemFont(ofSize: 17), leftNum: "\(servePointWon)%", rightNum: "\(servePointWon2)%")
        let serveGameWonConfig = TMPointComparingViewConfig(isTitleViewAbovePointView: false, isTitleHidden: false, title: NSLocalizedString("Serve Game Won", comment: ""), iconName: "checkmark.circle", isServingOnLeft: serveGameWon > serveGameWon2 ? true : false, areBothServing: false, isComparing: serveGameWon != serveGameWon2 ? true : false, font: UIFont.systemFont(ofSize: 17), leftNum: "\(serveGameWon)%", rightNum: "\(serveGameWon2)%")

        let firstReturnServeInConfig = TMPointComparingViewConfig(isTitleViewAbovePointView: false, isTitleHidden: false, title: NSLocalizedString("1ST Return In", comment: ""), iconName: "checkmark.circle", isServingOnLeft: firstReturnServeIn > firstReturnServeIn2 ? true : false, areBothServing: false, isComparing: firstReturnServeIn != firstReturnServeIn2 ? true : false, font: UIFont.systemFont(ofSize: 17), leftNum: "\(firstReturnServeIn)%", rightNum: "\(firstReturnServeIn2)%")
        let firstReturnServeWonConfig = TMPointComparingViewConfig(isTitleViewAbovePointView: false, isTitleHidden: false, title: NSLocalizedString("1ST Return Won", comment: ""), iconName: "checkmark.circle", isServingOnLeft: firstReturnServeWon > firstReturnServeWon2 ? true : false, areBothServing: false, isComparing: firstReturnServeWon != firstReturnServeWon2 ? true : false, font: UIFont.systemFont(ofSize: 17), leftNum: "\(firstReturnServeWon)%", rightNum: "\(firstReturnServeWon2)%")
        let secondReturnServeInConfig = TMPointComparingViewConfig(isTitleViewAbovePointView: false, isTitleHidden: false, title: NSLocalizedString("2ND Return In", comment: ""), iconName: "checkmark.circle", isServingOnLeft: secondReturnServeIn > secondReturnServeIn2 ? true : false, areBothServing: false, isComparing: secondReturnServeIn != secondReturnServeIn2 ? true : false, font: UIFont.systemFont(ofSize: 17), leftNum: "\(secondReturnServeIn)%", rightNum: "\(secondReturnServeIn2)%")
        let secondReturnServeWonConfig = TMPointComparingViewConfig(isTitleViewAbovePointView: false, isTitleHidden: false, title: NSLocalizedString("2ND Return Won", comment: ""), iconName: "checkmark.circle", isServingOnLeft: secondReturnServeWon > secondReturnServeWon2 ? true : false, areBothServing: false, isComparing: secondReturnServeWon != secondReturnServeWon2 ? true : false, font: UIFont.systemFont(ofSize: 17), leftNum: "\(secondReturnServeWon)%", rightNum: "\(secondReturnServeWon2)%")
        let breakPointConvertConfig = TMPointComparingViewConfig(isTitleViewAbovePointView: false, isTitleHidden: false, title: NSLocalizedString("Break Point Convert", comment: ""), iconName: "checkmark.circle", isServingOnLeft: breakPointConvert > breakPointConvert2 ? true : false, areBothServing: false, isComparing: breakPointConvert != breakPointConvert2 ? true : false, font: UIFont.systemFont(ofSize: 17), leftNum: "\(breakPointConvert)%", rightNum: "\(breakPointConvert2)%")
        let returnPointWonConfig = TMPointComparingViewConfig(isTitleViewAbovePointView: false, isTitleHidden: false, title: NSLocalizedString("Return Point Won", comment: ""), iconName: "checkmark.circle", isServingOnLeft: returnPointWon > returnPointWon2 ? true : false, areBothServing: false, isComparing: returnPointWon != returnPointWon2 ? true : false, font: UIFont.systemFont(ofSize: 17), leftNum: "\(returnPointWon)%", rightNum: "\(returnPointWon2)%")
        let returnGameWonConfig = TMPointComparingViewConfig(isTitleViewAbovePointView: false, isTitleHidden: false, title: NSLocalizedString("Return Game Won", comment: ""), iconName: "checkmark.circle", isServingOnLeft: returnGameWon > returnGameWon2 ? true : false, areBothServing: false, isComparing: returnGameWon != returnGameWon2 ? true : false, font: UIFont.systemFont(ofSize: 17), leftNum: "\(returnGameWon)%", rightNum: "\(returnGameWon2)%")

        let acesConfig = TMPointComparingViewConfig(isTitleViewAbovePointView: false, isTitleHidden: false, title: NSLocalizedString("Aces", comment: ""), iconName: "checkmark.circle", isServingOnLeft: game.player1Stats.aces > game.player2Stats.aces ? true : false, areBothServing: false, isComparing: game.player1Stats.aces != game.player2Stats.aces ? true : false, font: UIFont.systemFont(ofSize: 17), leftNum: "\(game.player1Stats.aces)", rightNum: "\(game.player2Stats.aces)")
        let doubleFaultsConfig = TMPointComparingViewConfig(isTitleViewAbovePointView: false, isTitleHidden: false, title: NSLocalizedString("Double Faults", comment: ""), iconName: "checkmark.circle", isServingOnLeft: game.player1Stats.doubleFaults > game.player2Stats.doubleFaults ? true : false, areBothServing: false, isComparing: game.player1Stats.doubleFaults != game.player2Stats.doubleFaults ? true : false, font: UIFont.systemFont(ofSize: 17), leftNum: "\(game.player1Stats.doubleFaults)", rightNum: "\(game.player2Stats.doubleFaults)")
        let returnAcesConfig = TMPointComparingViewConfig(isTitleViewAbovePointView: false, isTitleHidden: false, title: NSLocalizedString("Return Aces", comment: ""), iconName: "checkmark.circle", isServingOnLeft: game.player1Stats.returnAces > game.player2Stats.returnAces ? true : false, areBothServing: false, isComparing: game.player1Stats.returnAces != game.player2Stats.returnAces ? true : false, font: UIFont.systemFont(ofSize: 17), leftNum: "\(game.player1Stats.returnAces)", rightNum: "\(game.player2Stats.returnAces)")
        let netPointsConfig = TMPointComparingViewConfig(isTitleViewAbovePointView: false, isTitleHidden: false, title: NSLocalizedString("Net Points", comment: ""), iconName: "checkmark.circle", isServingOnLeft: game.player1Stats.netPoints > game.player2Stats.netPoints ? true : false, areBothServing: false, isComparing: game.player1Stats.netPoints != game.player2Stats.netPoints ? true : false, font: UIFont.systemFont(ofSize: 17), leftNum: "\(game.player1Stats.netPoints)", rightNum: "\(game.player2Stats.netPoints)")
        let unforcedErrorsConfig = TMPointComparingViewConfig(isTitleViewAbovePointView: false, isTitleHidden: false, title: NSLocalizedString("UEs", comment: ""), iconName: "checkmark.circle", isServingOnLeft: game.player1Stats.unforcedErrors > game.player2Stats.unforcedErrors ? true : false, areBothServing: false, isComparing: game.player1Stats.unforcedErrors != game.player2Stats.unforcedErrors ? true : false, font: UIFont.systemFont(ofSize: 17), leftNum: "\(game.player1Stats.unforcedErrors)", rightNum: "\(game.player2Stats.unforcedErrors)")
        let forehandWinnersConfig = TMPointComparingViewConfig(isTitleViewAbovePointView: false, isTitleHidden: false, title: NSLocalizedString("FH Winners", comment: ""), iconName: "checkmark.circle", isServingOnLeft: game.player1Stats.forehandWinners > game.player2Stats.forehandWinners ? true : false, areBothServing: false, isComparing: game.player1Stats.forehandWinners != game.player2Stats.forehandWinners ? true : false, font: UIFont.systemFont(ofSize: 17), leftNum: "\(game.player1Stats.forehandWinners)", rightNum: "\(game.player2Stats.forehandWinners)")
        let backhandWinnersConfig = TMPointComparingViewConfig(isTitleViewAbovePointView: false, isTitleHidden: false, title: NSLocalizedString("BH Winners", comment: ""), iconName: "checkmark.circle", isServingOnLeft: game.player1Stats.backhandWinners > game.player2Stats.backhandWinners ? true : false, areBothServing: false, isComparing: game.player1Stats.backhandWinners != game.player2Stats.backhandWinners ? true : false, font: UIFont.systemFont(ofSize: 17), leftNum: "\(game.player1Stats.backhandWinners)", rightNum: "\(game.player2Stats.backhandWinners)")

        let commonStatsViewConfig = TMmultiplyConfigurableViewConfig(rowHeight: 32, rowSpacing: 10, configs: [acesConfig, doubleFaultsConfig, returnAcesConfig, netPointsConfig, unforcedErrorsConfig, forehandWinnersConfig, backhandWinnersConfig])
        let resultViewConfig = TMmultiplyConfigurableViewConfig(rowHeight: 28, rowSpacing: 10, configs: multiConfig)
        let serveStatsViewConfig = TMmultiplyConfigurableViewConfig(rowHeight: 58, rowSpacing: 20, configs: [firstServeInConfig, firstServeWonConfig, secondServeInConfig, secondServeWonConfig, breakPointSavedConfig, servePointWonConfig, serveGameWonConfig])
        let returnStatsViewConfig = TMmultiplyConfigurableViewConfig(rowHeight: 58, rowSpacing: 20, configs: [firstReturnServeInConfig, firstReturnServeWonConfig, secondReturnServeInConfig, secondReturnServeWonConfig, breakPointConvertConfig, returnPointWonConfig, returnGameWonConfig])
        player1IconView.setupEvent(config: player1IconConfig)
        player2IconView.setupEvent(config: player2IconConfig)
        resultView.setupEvent(config: resultViewConfig)
        commonStatsView.setupEvent(config: commonStatsViewConfig)
        serveStatsView.setupEvent(config: serveStatsViewConfig)
        returnStatsView.setupEvent(config: returnStatsViewConfig)

        searchH2H(player1: game.player1.id, player2: game.player2.id)
    }

    func searchH2H(player1: Int, player2: Int) {
        var player1WinningNum = 0
        var player2WinningNum = 0

        games = searchH2H(for: player1, and: player2)
        for game in games {
            let result = TMDataConvert.setResult(from: game.result, isGameCompleted: true)
            if (result[0] > result[1]) == game.isPlayer1Left {
                player1WinningNum += 1
            } else {
                player2WinningNum += 1
            }

            H2HRecordView.updateLeftViewData(isServingOnLeft: false, newNum: "\(player1WinningNum)")
            H2HRecordView.updateRightViewData(isServingOnRight: false, newNum: "\(player2WinningNum)")
            progressView.progress = Float(player1WinningNum) / (Float(player2WinningNum) + Float(player1WinningNum))
            if progressView.progress == 0 {
                progressView.progressTintColor = UIColor(named: "Tennis") // 已有进度颜色
                progressView.trackTintColor = .gray
            } else if progressView.progress >= 0.5 {
                progressView.progressTintColor = UIColor(named: "Tennis") // 已有进度颜色
                progressView.trackTintColor = .gray
            } else if progressView.progress < 0.5 {
                let newProgress = 1 - progressView.progress
                progressView.progress = newProgress
                progressView.transform = CGAffineTransform(rotationAngle: -CGFloat.pi) // 已有进度颜色
                progressView.progressTintColor =
                    .gray // 已有进度颜色
                progressView.trackTintColor = UIColor(named: "Tennis")
            }
        }
    }

    func searchH2H(for player1Id: Int, and player2Id: Int) -> [Game] {
        var res: [Game] = []

        for game in TMUser.user.allHistoryGames {
            if game.player1.id == player1Id, game.player2.id == player2Id {
                res.append(game)
            }
            if game.player2.id == player1Id, game.player1.id == player2Id {
                res.append(game)
            }
        }
        return res
    }

    @objc func seePlayerInfo(sender: UITapGestureRecognizer) {
        let vc = TMCommonPlayerInfoViewController()
        if let tappedView = sender.view {
            if tappedView == player1IconView {
                // Do something for player 1
                vc.player = game.player1
            } else if tappedView == player2IconView {
                // Do something for player 2
                vc.player = game.player2
            }
            present(vc, animated: true)
        }
    }

    @objc func presentH2HView() {
        let vc = TMH2HViewController()
        vc.player1 = game.player1
        vc.player2 = game.player2
        vc.h2hGames = games
        present(vc, animated: true)
    }
}
