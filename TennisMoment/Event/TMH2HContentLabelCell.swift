//
//  TMH2HContentLabelCell.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/4/10.
//

import Foundation
import UIKit

class TMH2HContentLabelCell: UITableViewCell {
    lazy var winnerLabel: UILabel = {
        let iconView = UILabel()
        return iconView
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
        contentView.addSubview(dateLabel)
        contentView.addSubview(placeLabel)
        contentView.addSubview(roundLabel)
        contentView.addSubview(winnerLabel)
        contentView.addSubview(resultLabel)
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

        dateLabel.textAlignment = .center
        placeLabel.textAlignment = .center
        roundLabel.textAlignment = .center
        winnerLabel.textAlignment = .center
        resultLabel.textAlignment = .center

        dateLabel.text = NSLocalizedString("Date", comment: "")
        placeLabel.text = NSLocalizedString("Place", comment: "")
        roundLabel.text = NSLocalizedString("Rnd", comment: "")
        winnerLabel.text = NSLocalizedString("Winner", comment: "")
        resultLabel.text = NSLocalizedString("Result", comment: "")
    }
}
