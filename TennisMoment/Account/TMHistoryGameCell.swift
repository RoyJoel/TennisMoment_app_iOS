//
//  TMHistoryGameCell.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/4/15.
//
import CoreLocation
import Foundation
import MapKit
import UIKit

class TMHistoryGameCell: UITableViewCell {
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var opponentIcon: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    lazy var opponentLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var placeLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var resultLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(opponentIcon)
        contentView.addSubview(opponentLabel)
        contentView.addSubview(placeLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(resultLabel)
        contentView.backgroundColor = UIColor(named: "BackgroundGray")
        layoutSubviews()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        opponentIcon.snp.makeConstraints { make in
            make.right.equalTo(opponentLabel.snp.left)
            make.top.equalToSuperview().offset(6)
            make.bottom.equalToSuperview().offset(-6)
            make.width.equalTo(30)
        }
        opponentLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.right.equalTo(resultLabel.snp.left).offset(6)
            make.width.equalTo(148)
        }
        dateLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.width.equalTo(158)
        }
        placeLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(dateLabel.snp.right)
            make.right.equalTo(opponentLabel.snp.left)
        }
        resultLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(228)
            make.right.equalToSuperview()
        }
        opponentIcon.contentMode = .scaleAspectFill
        opponentIcon.setCorner(radii: 5)
        opponentIcon.clipsToBounds = true
    }

    func setupEvent(game: Game) {
        opponentIcon.image = UIImage(data: game.player1.id == TMUser.user.id ? game.player2.icon.toPng() : game.player1.icon.toPng())
        opponentLabel.text = game.player1.id == TMUser.user.id ? game.player2.name : game.player1.name
        dateLabel.text = game.startDate.convertToString(formatterString: "yyyy MM-dd HH:mm")
        placeLabel.text = game.place
        let liveResult = TMDataConvert.gameResult(from: game.result, isGameCompleted: true)
        var lastRecord = ""
        for set in liveResult {
            lastRecord += " \(set[0]) : \(set[1]) "
        }
        resultLabel.text = lastRecord
        resultLabel.sizeToFit()
    }
}
