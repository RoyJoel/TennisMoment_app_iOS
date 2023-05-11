//
//  TMPointRecordView.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/2/23.
//

import Foundation
import TMComponent

class TMPointRecordView: TMView {
    var config = TMPointRecordViewConfig(rowHeight: 0, rowSpacing: 0, font: UIFont(), isTitleHidden: true, isPlayer1Serving: true, isPlayer1Left: true, isGameCompleted: true, player1SetNum: 0, player2SetNum: 0, player1GameNum: 0, player2GameNum: 0, player1PointNum: "0", player2PointNum: "0")

    var pointRecordView: TMmultiplyConfigurableView = {
        let view = TMmultiplyConfigurableView()
        return view
    }()

    func setup(with config: TMPointRecordViewConfig) {
        self.config = config

        let setConfig = TMPointComparingViewConfig(isTitleViewAbovePointView: true, isTitleHidden: config.isTitleHidden, title: NSLocalizedString("SET", comment: ""), isServingOnLeft: true, areBothServing: false, isComparing: false, font: config.font, leftNum: "\(config.player1SetNum)", rightNum: "\(config.player2SetNum)")
        let gameConfig = TMPointComparingViewConfig(isTitleViewAbovePointView: true, isTitleHidden: config.isTitleHidden, title: NSLocalizedString("GAME", comment: ""), isServingOnLeft: true, areBothServing: false, isComparing: false, font: config.font, leftNum: "\(config.player1GameNum)", rightNum: "\(config.player2GameNum)")
        let pointConfig = TMPointComparingViewConfig(isTitleViewAbovePointView: true, isTitleHidden: config.isTitleHidden, title: NSLocalizedString("POINT", comment: ""), iconName: "TennisBall", isServingOnLeft: true, areBothServing: false, isComparing: config.isGameCompleted ? false : true, font: config.font, leftNum: "\(config.player1PointNum)", rightNum: "\(config.player2PointNum)")
        let pointRecordViewConfig = TMmultiplyConfigurableViewConfig(rowHeight: config.rowHeight, rowSpacing: config.rowSpacing, configs: [setConfig, gameConfig, pointConfig])

        setupEvent(config: pointRecordViewConfig)
    }

    func updateData(liveScore: [[[Int]]], isPlayer1Serving: Bool, isPlayer1Left: Bool, isGameCompleted: Bool, setConfigNum _: Int, gameConfigNum: Int) {
        let result = TMDataConvert.read(from: liveScore, isGameCompleted: isGameCompleted, gameConfigNum: gameConfigNum)
        let score = result.0
        let isInTieBreak = result.1

        let isServingOnLeft = isPlayer1Left == isPlayer1Serving

        config = TMPointRecordViewConfig(rowHeight: 0, rowSpacing: 0, font: UIFont(), isTitleHidden: true, isPlayer1Serving: isPlayer1Serving, isPlayer1Left: isPlayer1Left, isGameCompleted: isGameCompleted, player1SetNum: score[0][0], player2SetNum: score[0][1], player1GameNum: score[1][0], player2GameNum: score[1][1], player1PointNum: isInTieBreak ? "\(score[2][0])" : score[2][0].convertToPoint(), player2PointNum: isInTieBreak ? "\(score[2][1])" : score[2][1].convertToPoint())

        if !isPlayer1Left {
            TMDataConvert.changePosition(with: &config.player1SetNum, and: &config.player2SetNum)
            TMDataConvert.changePosition(with: &config.player1GameNum, and: &config.player2GameNum)
            let t = config.player1PointNum
            config.player1PointNum = config.player2PointNum
            config.player2PointNum = t
        }
        pointRecordView.updateLeftDate(at: 0, isServingOnLeft: false, newNum: "\(config.player1SetNum)")
        pointRecordView.updateRightDate(at: 0, isServingOnRight: false, newNum: "\(config.player2SetNum)")
        pointRecordView.updateLeftDate(at: 1, isServingOnLeft: false, newNum: "\(config.player1GameNum)")
        pointRecordView.updateRightDate(at: 1, isServingOnRight: false, newNum: "\(config.player2GameNum)")
        pointRecordView.updateLeftDate(at: 2, isServingOnLeft: config.isGameCompleted ? false : isServingOnLeft, newNum: config.player1PointNum)
        pointRecordView.updateRightDate(at: 2, isServingOnRight: config.isGameCompleted ? false : !isServingOnLeft, newNum: config.player2PointNum)
    }

    func updateLeftData(at index: Int, isServingOnLeft: Bool, newNum: String) {
        pointRecordView.updateLeftDate(at: index, isServingOnLeft: isServingOnLeft, newNum: newNum)
    }

    func updateRightData(at index: Int, isServingOnRight: Bool, newNum: String) {
        pointRecordView.updateRightDate(at: index, isServingOnRight: isServingOnRight, newNum: newNum)
    }

    func scaleTo(newRowHeight: CGFloat, newRowSpacing: CGFloat, newFont: UIFont, isTitleHidden: Bool) {
        let isServingOnLeft = config.isPlayer1Left == config.isPlayer1Serving

        let setConfig = TMPointComparingViewConfig(isTitleViewAbovePointView: true, isTitleHidden: isTitleHidden, title: NSLocalizedString("SET", comment: ""), isServingOnLeft: true, areBothServing: false, isComparing: false, font: newFont, leftNum: "\(config.player1SetNum)", rightNum: "\(config.player2SetNum)")
        let gameConfig = TMPointComparingViewConfig(isTitleViewAbovePointView: true, isTitleHidden: isTitleHidden, title: NSLocalizedString("GAME", comment: ""), isServingOnLeft: true, areBothServing: false, isComparing: false, font: newFont, leftNum: "\(config.player1GameNum)", rightNum: "\(config.player2GameNum)")
        let pointConfig = TMPointComparingViewConfig(isTitleViewAbovePointView: true, isTitleHidden: isTitleHidden, title: NSLocalizedString("POINT", comment: ""), iconName: "TennisBall", isServingOnLeft: isServingOnLeft, areBothServing: false, isComparing: config.isGameCompleted ? false : true, font: newFont, leftNum: config.player1PointNum, rightNum: config.player2PointNum)
        let pointRecordViewConfig = TMmultiplyConfigurableViewConfig(rowHeight: newRowHeight, rowSpacing: newRowSpacing, configs: [setConfig, gameConfig, pointConfig])
        pointRecordView.reset(with: pointRecordViewConfig)
    }

    func setupUI() {
        addSubview(pointRecordView)
        pointRecordView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        pointRecordView.setupUI()
    }

    func setupEvent(config: TMmultiplyConfigurableViewConfig) {
        pointRecordView.setupEvent(config: config)
    }
}
