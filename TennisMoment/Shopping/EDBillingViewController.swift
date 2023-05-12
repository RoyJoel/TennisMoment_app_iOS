//
//  TMBillingViewController.swift
//  TMMS
//
//  Created by Jason Zhang on 2023/4/24.
//

import Foundation
import UIKit

class TMBillingViewController: UIViewController {
    var order = Order()

    lazy var checkoutTitleView: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var billView: TMBillingView = {
        let view = TMBillingView()
        return view
    }()

    lazy var addressView: TMAddressView = {
        let view = TMAddressView()
        return view
    }()

    lazy var wayOfPayView: TMPaymentView = {
        let view = TMPaymentView()
        return view
    }()

    lazy var deliWayLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var deliWayView: UIView = {
        let view = UIView()
        return view
    }()

    lazy var deliWayBackgroundView: UIView = {
        let view = UIView()
        return view
    }()

    lazy var discBackgroundView: UIView = {
        let view = UIView()
        return view
    }()

    lazy var discLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var discView: UIView = {
        let view = UIView()
        return view
    }()

    lazy var totalLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var totalNumLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var confirmBtn: UIButton = {
        let btn = UIButton()
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = UIColor(named: "ContentBackground")
        view = TMBillVCView()
        view.addSubview(checkoutTitleView)
        view.addSubview(billView)
        view.addSubview(addressView)
        view.addSubview(wayOfPayView)
        view.addSubview(deliWayBackgroundView)
        deliWayBackgroundView.addSubview(deliWayLabel)
        deliWayBackgroundView.addSubview(deliWayView)
        view.addSubview(discBackgroundView)
        discBackgroundView.addSubview(discLabel)
        discBackgroundView.addSubview(discView)
        view.addSubview(totalLabel)
        view.addSubview(totalNumLabel)
        view.addSubview(confirmBtn)

        checkoutTitleView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(24)
            make.top.equalToSuperview().offset(32)
            make.width.equalTo(108)
            make.height.equalTo(50)
        }

        billView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(24)
            make.top.equalTo(checkoutTitleView.snp.bottom).offset(12)
            make.height.equalTo(168)
            make.right.equalToSuperview().offset(-24)
        }
        addressView.snp.makeConstraints { make in
            make.left.equalTo(billView.snp.left)
            make.top.equalTo(billView.snp.bottom).offset(24)
            make.width.equalToSuperview().dividedBy(2).offset(-24)
            make.bottom.equalToSuperview().offset(-24)
        }
        wayOfPayView.frame = CGRect(x: 376, y: 286, width: 304, height: 68)

        totalLabel.snp.makeConstraints { make in
            make.left.equalTo(wayOfPayView.snp.left)
            make.bottom.equalTo(confirmBtn.snp.top).offset(-24)

            make.height.equalTo(50)
        }

        totalNumLabel.snp.makeConstraints { make in
            make.right.equalTo(wayOfPayView.snp.right)
            make.bottom.equalTo(totalLabel.snp.bottom)
            make.height.equalTo(50)
        }

        confirmBtn.snp.makeConstraints { make in
            make.right.equalTo(wayOfPayView.snp.right)
            make.bottom.equalToSuperview().offset(-24)
            make.width.equalTo(108)
            make.height.equalTo(50)
        }

        totalLabel.text = "Total"
        totalLabel.font = UIFont.systemFont(ofSize: 26)

        var totalNum: Double = 0
        for bill in order.bills {
            totalNum += bill.com.price * Double(bill.quantity)
        }
        totalNumLabel.text = "¥" + String(format: "%.2f", totalNum)
        totalNumLabel.font = UIFont.systemFont(ofSize: 22)

        checkoutTitleView.text = "Check Out"
        checkoutTitleView.font = UIFont.systemFont(ofSize: 23)
        billView.setup(with: order.bills)
        addressView.setupUI()
        addressView.setupEvent(address: order.deliveryAddress)
        wayOfPayView.setupUI()
        wayOfPayView.setCorner(radii: 15)
        wayOfPayView.backgroundColor = UIColor(named: "ComponentBackground")
        wayOfPayView.setupEvent(title: "Payment", info: "wechat")
        wayOfPayView.clipsToBounds = false

        confirmBtn.setTitle("Pay", for: .normal)
        confirmBtn.backgroundColor = UIColor(named: "TennisBlur")
        confirmBtn.setTitleColor(.black, for: .normal)
        confirmBtn.addTarget(self, action: #selector(pay), for: .touchDown)
        confirmBtn.setCorner(radii: 15)
    }

    @objc func pay() {}
}
