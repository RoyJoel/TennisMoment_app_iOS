//
//  TMEventGameCell.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/3/19.
//

import Foundation
import TMComponent
import UIKit

class TMEventGameCell: UITableViewCell {
    lazy var backgroundCell: UIView = {
        let view = UIView()
        return view
    }()

    lazy var titleView: UILabel = {
        let view = UILabel()
        return view
    }()

    /// 左侧球员信息
    lazy var leftBasicInfoView: TMIconView = {
        var view = TMIconView()
        view.isUserInteractionEnabled = false
        return view
    }()

    /// 右侧球员信息
    lazy var rightBasicInfoView: TMIconView = {
        var view = TMIconView()
        view.isUserInteractionEnabled = false
        return view
    }()

    /// 记分板
    lazy var recordPointView: TMPointRecordView = {
        let view = TMPointRecordView()
        view.isUserInteractionEnabled = false
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(backgroundCell)
        backgroundCell.addSubview(titleView)
        backgroundCell.addSubview(leftBasicInfoView)
        backgroundCell.addSubview(rightBasicInfoView)
        backgroundCell.addSubview(recordPointView)
        layoutSubviews()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundCell.setCorner(radii: 15)
        backgroundCell.backgroundColor = UIColor(named: "ComponentBackground")
        backgroundCell.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(6)
            make.right.equalToSuperview().offset(-6)
        }

        titleView.textColor = UIColor(named: "ContentBackground")
        titleView.font = UIFont.systemFont(ofSize: 17)

        titleView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.top.equalToSuperview().offset(12)
            make.width.equalTo(UIStandard.shared.screenWidth * 0.1)
            make.height.equalTo(22)
        }
        leftBasicInfoView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(18)
            make.right.equalTo(recordPointView.snp.left).offset(-6)
            make.top.equalTo(titleView.snp.bottom).offset(6)
            make.bottom.equalTo(recordPointView.snp.bottom).offset(28)
        }
        rightBasicInfoView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-18)
            make.top.equalTo(leftBasicInfoView.snp.top)
            make.left.equalTo(recordPointView.snp.right).offset(6)
            make.bottom.equalTo(recordPointView.snp.bottom).offset(28)
        }
        recordPointView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(bounds.width * 0.3)
            make.height.equalTo(84)
        }
        leftBasicInfoView.setupUI()
        rightBasicInfoView.setupUI()
        recordPointView.setupUI()
    }

    func setupEvent(game: Game) {
        let pointRecordViewConfig = TMPointRecordViewConfig(rowHeight: 28, rowSpacing: 0, font: UIFont.systemFont(ofSize: 13), isTitleHidden: true, isPlayer1Serving: true, isPlayer1Left: true, isGameCompleted: true, player1SetNum: 0, player2SetNum: 0, player1GameNum: 0, player2GameNum: 0, player1PointNum: "0", player2PointNum: "0")
        recordPointView.setup(with: pointRecordViewConfig)
        // 说明player1在左侧⬅️
        if game.isPlayer1Left {
            leftBasicInfoView.updateInfo(with: game.player1.icon.toPng(), named: game.player1.name)
            rightBasicInfoView.updateInfo(with: game.player2.icon.toPng(), named: game.player2.name)
        } else {
            leftBasicInfoView.updateInfo(with: game.player2.icon.toPng(), named: game.player2.name)
            rightBasicInfoView.updateInfo(with: game.player1.icon.toPng(), named: game.player1.name)
        }
        if Date().timeIntervalSince1970 < game.endDate || game.endDate == 0 {
            titleView.text = NSLocalizedString("Live", comment: "")
            recordPointView.updateData(liveScore: game.result, isPlayer1Serving: game.isPlayer1Serving, isPlayer1Left: game.isPlayer1Left, isGameCompleted: false, setConfigNum: game.setNum, gameConfigNum: game.gameNum)
        } else if Date().timeIntervalSince1970 > game.endDate, game.endDate != 0 {
            titleView.text = NSLocalizedString("Completed", comment: "")
            recordPointView.updateData(liveScore: game.result, isPlayer1Serving: game.isPlayer1Serving, isPlayer1Left: game.isPlayer1Left, isGameCompleted: true, setConfigNum: game.setNum, gameConfigNum: game.gameNum)
        } else if Date().timeIntervalSince1970 < game.startDate {
            titleView.text = NSLocalizedString("In Turn", comment: "")
            recordPointView.updateData(liveScore: game.result, isPlayer1Serving: game.isPlayer1Serving, isPlayer1Left: game.isPlayer1Left, isGameCompleted: false, setConfigNum: game.setNum, gameConfigNum: game.gameNum)
        }
    }
}
