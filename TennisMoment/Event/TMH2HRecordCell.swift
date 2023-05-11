//
//  TMH2HRecordCell.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/4/9.
//

import Foundation
import UIKit

class TMH2HRecordCell: UITableViewCell {
    lazy var winnerLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var dateLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var placeLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var roundLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var resultLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(winnerLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(placeLabel)
        contentView.addSubview(roundLabel)
        contentView.addSubview(resultLabel)
        contentView.backgroundColor = UIColor(named: "ComponentBackground")
        layoutSubviews()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        dateLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(6)
            make.width.equalTo(128)
        }
        placeLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(dateLabel.snp.right)
            make.right.equalTo(roundLabel.snp.left)
        }
        roundLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.right.equalTo(winnerLabel.snp.left)
            make.width.equalTo(48)
        }
        winnerLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.right.equalTo(resultLabel.snp.left)
            make.width.equalTo(146)
        }
        resultLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(6)
            make.width.equalTo(258)
        }
    }

    func setupEvent(game: Game) {
        dateLabel.text = "\(game.startDate.convertToString(formatterString: "yyyy MM-dd"))"
        placeLabel.text = "\(game.place)"
        roundLabel.text = "\(game.round)"
        let result = TMDataConvert.gameResult(from: game.result, isGameCompleted: true)
        let setResult = TMDataConvert.setResult(from: game.result, isGameCompleted: true)
        if setResult[0] > setResult[1], game.isPlayer1Left {
            winnerLabel.text = "\(game.player1.name)"
        } else {
            winnerLabel.text = "\(game.player2.name)"
        }
        var resultText = ""
        for set in result {
            resultText += " \(set[0]) : \(set[1]) "
        }
        resultLabel.text = resultText
        dateLabel.textAlignment = .center
        placeLabel.textAlignment = .center
        roundLabel.textAlignment = .center
        winnerLabel.textAlignment = .center
        resultLabel.textAlignment = .center
    }
}
