//
//  TMUnfinishedGameCell.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/4/10.
//
import CoreLocation
import Foundation
import MapKit
import UIKit

class TMUnfinishedGameCell: UITableViewCell {
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

    lazy var lastRecordLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(opponentIcon)
        contentView.addSubview(opponentLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(lastRecordLabel)
        contentView.backgroundColor = UIColor(named: "ComponentBackground")
        layoutSubviews()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        opponentIcon.snp.makeConstraints { make in
            make.left.equalTo(dateLabel.snp.right)
            make.top.equalToSuperview().offset(6)
            make.bottom.equalToSuperview().offset(-6)
            make.width.equalTo(30)
        }
        opponentLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(opponentIcon.snp.right).offset(6)
            make.width.equalTo(116)
        }
        dateLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.width.equalTo(158)
        }
        lastRecordLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(opponentLabel.snp.right)
        }
        opponentIcon.contentMode = .scaleAspectFill
        opponentIcon.setCorner(radii: 5)
        opponentIcon.clipsToBounds = true
    }

    func setupEvent(game: Game) {
        opponentIcon.image = UIImage(data: game.player1.id == TMUser.user.id ? game.player2.icon.toPng() : game.player1.icon.toPng())
        opponentLabel.text = game.player1.id == TMUser.user.id ? game.player2.name : game.player1.name
        dateLabel.text = game.startDate.convertToString(formatterString: "yyyy MM-dd HH:mm")
        let liveResult = TMDataConvert.gameResult(from: game.result, isGameCompleted: false)
        var lastRecord = ""
        for set in liveResult {
            lastRecord += " \(set[0]):\(set[1]) "
        }
        lastRecordLabel.text = lastRecord
        lastRecordLabel.sizeToFit()
    }

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if CGRectContainsPoint(lastRecordLabel.frame, point) {
            return lastRecordLabel
        }
        return super.hitTest(point, with: event)
    }
}
