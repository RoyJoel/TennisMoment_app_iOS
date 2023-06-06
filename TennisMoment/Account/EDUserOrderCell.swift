//
//  TMUserOrderCell.swift
//  TMMS
//
//  Created by Jason Zhang on 2023/4/29.
//

import Foundation
import UIKit

class TMUserOrderCell: UITableViewCell {
    lazy var orderLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var BillingView: TMBillingView = {
        let view = TMBillingView()
        view.isOrderCell = true
        return view
    }()

    lazy var paymentAndPriceLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(orderLabel)
        contentView.addSubview(BillingView)
        contentView.addSubview(paymentAndPriceLabel)
        layoutSubviews()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        orderLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
            make.height.equalTo(50)
            make.top.equalToSuperview().offset(12)
        }

        BillingView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
            make.top.equalTo(orderLabel.snp.bottom).offset(8)
            make.height.equalTo(68)
        }
        paymentAndPriceLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-24)
            make.top.equalTo(BillingView.snp.bottom).offset(8)
            make.height.equalTo(30)
        }
        orderLabel.font = UIFont.systemFont(ofSize: 22)
        paymentAndPriceLabel.font = UIFont.systemFont(ofSize: 16)
        paymentAndPriceLabel.textAlignment = .right
        paymentAndPriceLabel.textColor = UIColor(named: "blurGray")
    }

    func setupEvent(order: Order) {
        orderLabel.text = "Order #\(order.id)"
        BillingView.setup(with: order.bills)
        paymentAndPriceLabel.text = "\(order.payment.displayName)¥\(TMDataConvert.getTotalPrice(order.bills))"
    }
}
