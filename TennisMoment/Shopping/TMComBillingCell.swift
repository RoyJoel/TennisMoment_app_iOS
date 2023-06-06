//
// TMComBillingCell.swift
// TennisMoment
//
//  Created by Jason Zhang on 2023/4/24.
//

import Foundation
import UIKit

class TMComBillingCell: UITableViewCell {
    lazy var comIconView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    lazy var nameView: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var configLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var quantityLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var priceLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(comIconView)
        contentView.addSubview(nameView)
        contentView.addSubview(configLabel)
        contentView.addSubview(quantityLabel)
        contentView.addSubview(priceLabel)

        layoutSubviews()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        comIconView.snp.makeConstraints { make in
            make.top.equalTo(nameView.snp.top)
            make.bottom.equalTo(configLabel.snp.bottom)
            make.width.equalTo(comIconView.snp.height)
            make.left.equalToSuperview().offset(12)
        }

        nameView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.height.equalTo(50)
            make.left.equalTo(comIconView.snp.right).offset(6)
            make.right.equalToSuperview().offset(-12)
        }

        configLabel.snp.makeConstraints { make in
            make.height.equalTo(46)
            make.top.equalTo(nameView.snp.bottom).offset(6)
            make.left.equalTo(comIconView.snp.right).offset(6)
            make.right.equalTo(priceLabel.snp.left).offset(-6)
        }

        quantityLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-12)
            make.top.equalTo(nameView.snp.bottom).offset(6)
            make.bottom.equalTo(configLabel.snp.bottom)
        }

        priceLabel.snp.makeConstraints { make in
            make.right.equalTo(quantityLabel.snp.left).offset(-6)
            make.top.equalTo(nameView.snp.bottom).offset(6)
            make.bottom.equalTo(configLabel.snp.bottom)
        }
        comIconView.setCorner(radii: 10)
        quantityLabel.textAlignment = .right
        priceLabel.textAlignment = .right
        priceLabel.font = UIFont.systemFont(ofSize: 17)
        nameView.font = UIFont.systemFont(ofSize: 20)
        nameView.numberOfLines = 2
        configLabel.numberOfLines = 2
        configLabel.font = UIFont.systemFont(ofSize: 16)
        configLabel.textColor = UIColor(named: "SubTitleColor")
        quantityLabel.font = UIFont.systemFont(ofSize: 17)
        quantityLabel.textColor = UIColor(named: "SubTitleColor")
    }

    func setupEvent(bill: Bill) {
        comIconView.image = UIImage(data: bill.option.image.toPng())
        nameView.text = bill.com.name
        configLabel.text = "已选\(bill.option.intro)"
        quantityLabel.text = "x\(bill.quantity)"
        priceLabel.text = "¥\(bill.option.price)"
    }
}
