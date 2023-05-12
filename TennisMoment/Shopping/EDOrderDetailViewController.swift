//
//  TMOrderDetailViewController.swift
//  TMMS
//
//  Created by Jason Zhang on 2023/5/8.
//

import Foundation
import UIKit

class TMOrderDetailViewController: UIViewController {
    var order = Order()
    lazy var addressView: TMAddressCell = {
        let view = TMAddressCell()
        return view
    }()

    lazy var addressViewBackground: UIView = {
        let view = UIView()
        return view
    }()

    lazy var orderStateLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var orderLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var orderNumLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var billingView: TMBillingView = {
        let view = TMBillingView()
        return view
    }()

    lazy var billingViewBackground: UIView = {
        let view = UIView()
        return view
    }()

    lazy var paymentLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var paymentNameLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var priceNumLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var priceLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var sentBtn: UIButton = {
        let btn = UIButton()
        return btn
    }()

    lazy var cancelBtn: UIButton = {
        let btn = UIButton()
        return btn
    }()

    lazy var orderCreateTimeLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var createTimeLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var orderPayedTimeLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var payedTimeLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var orderDoneTimeLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var doneTimeLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "BackgroundGray")
        view.addSubview(orderStateLabel)
        view.addSubview(addressViewBackground)
        view.addSubview(billingViewBackground)
        addressViewBackground.addSubview(addressView)
        billingViewBackground.addSubview(billingView)
        view.addSubview(paymentLabel)
        view.addSubview(paymentNameLabel)
        view.addSubview(priceLabel)
        view.addSubview(priceNumLabel)
        view.addSubview(orderLabel)
        view.addSubview(orderNumLabel)
        view.addSubview(orderCreateTimeLabel)
        view.addSubview(createTimeLabel)
        view.addSubview(orderPayedTimeLabel)
        view.addSubview(payedTimeLabel)
        view.addSubview(orderDoneTimeLabel)
        view.addSubview(doneTimeLabel)
        view.addSubview(cancelBtn)
        view.addSubview(sentBtn)

        orderStateLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
            make.top.equalToSuperview().offset(98)
            make.height.equalTo(40)
        }

        addressViewBackground.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.top.equalTo(orderStateLabel.snp.bottom).offset(12)
            make.height.equalTo(143)
        }

        billingViewBackground.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.top.equalTo(addressView.snp.bottom).offset(12)
            make.height.equalTo(88)
        }

        addressView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
        }

        billingView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
        }

        paymentLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(24)
            make.top.equalTo(billingView.snp.bottom).offset(12)
            make.height.equalTo(30)
        }
        priceLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(24)
            make.top.equalTo(paymentLabel.snp.bottom).offset(12)
            make.height.equalTo(30)
        }

        paymentNameLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-24)
            make.top.equalTo(paymentLabel.snp.top)
            make.height.equalTo(30)
        }

        priceNumLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-24)
            make.top.equalTo(priceLabel.snp.top)
            make.height.equalTo(30)
        }

        orderLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(24)
            make.height.equalTo(30)
            make.top.equalTo(priceLabel.snp.bottom).offset(12)
        }

        orderCreateTimeLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(24)
            make.height.equalTo(30)
            make.top.equalTo(orderLabel.snp.bottom).offset(12)
        }

        orderPayedTimeLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(24)
            make.height.equalTo(30)
            make.top.equalTo(orderCreateTimeLabel.snp.bottom).offset(12)
        }

        orderDoneTimeLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(24)
            make.height.equalTo(30)
            make.top.equalTo(orderPayedTimeLabel.snp.bottom).offset(12)
        }

        orderNumLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-24)
            make.height.equalTo(30)
            make.top.equalTo(priceNumLabel.snp.bottom).offset(12)
        }

        createTimeLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-24)
            make.height.equalTo(30)
            make.top.equalTo(orderNumLabel.snp.bottom).offset(12)
        }

        payedTimeLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-24)
            make.height.equalTo(30)
            make.top.equalTo(createTimeLabel.snp.bottom).offset(12)
        }

        doneTimeLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-24)
            make.height.equalTo(30)
            make.top.equalTo(payedTimeLabel.snp.bottom).offset(12)
        }
        cancelBtn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-138)
            make.width.equalTo(108)
            make.height.equalTo(50)
            make.left.equalToSuperview().offset(32)
        }

        sentBtn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-138)
            make.width.equalTo(108)
            make.height.equalTo(50)
            make.right.equalToSuperview().offset(-32)
        }

        orderStateLabel.text = order.state.displayName
        orderStateLabel.font = UIFont.systemFont(ofSize: 24)
        addressView.setupEvent(address: order.deliveryAddress, canEdit: order.state == .ToPay || order.state == .ToSend)
        billingView.setup(with: order.bills)
        paymentLabel.text = "支付方式"
        paymentNameLabel.text = order.payment.rawValue
        priceNumLabel.text = "¥\(order.totalPrice)"
        priceLabel.text = "总计"
        cancelBtn.setTitle("取消订单", for: .normal)
        cancelBtn.setTitleColor(UIColor(named: "ContentBackground"), for: .normal)
        cancelBtn.backgroundColor = UIColor(named: "ComponentBackground")
        cancelBtn.setCorner(radii: 10)
        if order.state == .ToSend {
            sentBtn.setTitle("一键发货", for: .normal)
        } else if order.state == .ToDelivery {
            sentBtn.setTitle("一键拦截", for: .normal)
        } else if order.state == .ToRefund || order.state == .ToReturn {
            sentBtn.setTitle("确认", for: .normal)
        } else {
            sentBtn.isHidden = true
            cancelBtn.isHidden = true
        }
        sentBtn.setTitleColor(UIColor(named: "ContentBackground"), for: .normal)
        sentBtn.backgroundColor = UIColor(named: "TennisBlur")
        sentBtn.setCorner(radii: 10)
        cancelBtn.addTarget(self, action: #selector(cancelOrder), for: .touchDown)
        sentBtn.addTarget(self, action: #selector(sentOrder), for: .touchDown)
        orderLabel.text = "订单编号"
        orderNumLabel.text = "\(order.id)"
        orderCreateTimeLabel.text = "创建时间"
        createTimeLabel.text = order.createdTime.convertToString()

        if let payedTime = order.payedTime {
            orderPayedTimeLabel.isHidden = false
            payedTimeLabel.isHidden = false
            orderPayedTimeLabel.text = "支付时间"
            payedTimeLabel.text = payedTime.convertToString()
        } else {
            orderPayedTimeLabel.isHidden = true
            payedTimeLabel.isHidden = true
        }

        if let doneTime = order.completedTime {
            orderDoneTimeLabel.isHidden = false
            doneTimeLabel.isHidden = false
            orderDoneTimeLabel.text = "完成时间"
            doneTimeLabel.text = doneTime.convertToString()
        } else {
            orderDoneTimeLabel.isHidden = true
            doneTimeLabel.isHidden = true
        }

        addressView.backgroundColor = UIColor(named: "ComponentBackground")
        addressViewBackground.setCorner(radii: 10)
        addressViewBackground.backgroundColor = UIColor(named: "ComponentBackground")
        billingViewBackground.setCorner(radii: 10)
        billingViewBackground.backgroundColor = UIColor(named: "ComponentBackground")
    }

    @objc func cancelOrder() {}

    @objc func sentOrder() {
        let vc = TMDeliveryViewController()
        navigationController?.present(vc, animated: true)
    }
}
