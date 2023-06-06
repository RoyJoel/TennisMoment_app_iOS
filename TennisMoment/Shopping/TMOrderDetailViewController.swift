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
    var completionHandler: ((Order) -> Void)?
    var deleteCompletionHandler: (() -> Void)?
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
        view.isOrderCell = true
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

    lazy var saveBtn: UIButton = {
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
        view.addSubview(saveBtn)

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

        saveBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(108)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-138)
        }

        orderStateLabel.text = order.state.displayName
        orderStateLabel.font = UIFont.systemFont(ofSize: 24)
        addressView.setupEvent(address: TMUser.user.defaultAddress)
        billingView.setup(with: order.bills)
//        paymentLabel.text = "支付方式"
//        paymentNameLabel.text = order.payment.displayName
        priceNumLabel.text = "\(TMDataConvert.getTotalPrice(order.bills))积分"
        priceLabel.text = "总计"
        cancelBtn.setTitleColor(UIColor(named: "ContentBackground"), for: .normal)
        cancelBtn.backgroundColor = UIColor(named: "ComponentBackground")
        cancelBtn.setCorner(radii: 10)
        saveBtn.setTitleColor(UIColor(named: "ContentBackground"), for: .normal)
        saveBtn.backgroundColor = UIColor(named: "TennisBlur")
        saveBtn.setCorner(radii: 10)
        saveBtn.isHidden = true
        if order.state == .ToPay {
            saveBtn.isHidden = false
            sentBtn.setTitle("修改地址", for: .normal)
            sentBtn.addTarget(self, action: #selector(changeAddress), for: .touchDown)
            saveBtn.setTitle("现在支付", for: .normal)
            saveBtn.addTarget(self, action: #selector(buy), for: .touchDown)
            cancelBtn.setTitle("取消订单", for: .normal)
            cancelBtn.isHidden = false
            cancelBtn.addTarget(self, action: #selector(cancelOrder), for: .touchDown)
        } else if order.state == .ToSend {
            sentBtn.setTitle("修改地址", for: .normal)
            sentBtn.addTarget(self, action: #selector(changeAddress), for: .touchDown)
            cancelBtn.isHidden = true
        } else if order.state == .ToDelivery {
            sentBtn.setTitle("确认收货", for: .normal)
            sentBtn.addTarget(self, action: #selector(confirmDelivery), for: .touchDown)
            cancelBtn.isHidden = true
        } else if order.state == .ToRefund {
            sentBtn.setTitle("我已发货", for: .normal)
            sentBtn.addTarget(self, action: #selector(sentOrder), for: .touchDown)
            cancelBtn.addTarget(self, action: #selector(cancelRefund), for: .touchDown)
            cancelBtn.setTitle("取消退货", for: .normal)
            cancelBtn.isHidden = false
        } else if order.state == .ToReturn {
            sentBtn.setTitle("取消退款", for: .normal)
            sentBtn.addTarget(self, action: #selector(cancelReturn), for: .touchDown)
            sentBtn.isHidden = false
            cancelBtn.isHidden = true
        } else {
            sentBtn.isHidden = true
            cancelBtn.isHidden = true
        }
        sentBtn.setTitleColor(UIColor(named: "ContentBackground"), for: .normal)
        sentBtn.backgroundColor = UIColor(named: "TennisBlur")
        sentBtn.setCorner(radii: 10)
        orderLabel.text = "订单编号"
        orderNumLabel.text = "\(order.id)"
        orderCreateTimeLabel.text = "创建时间"
        createTimeLabel.text = order.createdTime.convertToString()

        if order.state != .ToPay {
            orderPayedTimeLabel.isHidden = false
            payedTimeLabel.isHidden = false
            orderPayedTimeLabel.text = "支付时间"
            payedTimeLabel.text = order.payedTime?.convertToString()
        } else {
            orderPayedTimeLabel.isHidden = true
            payedTimeLabel.isHidden = true
        }

        if order.state == .Done {
            orderDoneTimeLabel.isHidden = false
            doneTimeLabel.isHidden = false
            orderDoneTimeLabel.text = "完成时间"
            doneTimeLabel.text = order.completedTime?.convertToString()
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

    @objc func cancelOrder() {
        TMOrderRequest.deleteOrder(id: order.id) { _ in
            let toastView = UILabel()
            toastView.text = NSLocalizedString("成功取消", comment: "")
            toastView.numberOfLines = 2
            toastView.bounds = CGRect(x: 0, y: 0, width: 350, height: 150)
            toastView.backgroundColor = UIColor(named: "ComponentBackground")
            toastView.textAlignment = .center
            toastView.setCorner(radii: 15)
            self.view.showToast(toastView, duration: 1, point: CGPoint(x: self.view.bounds.width / 2, y: self.view.bounds.height / 2)) { _ in
                (self.deleteCompletionHandler ?? {})()
                NotificationCenter.default.post(name: Notification.Name(ToastNotification.refreshOrderData.rawValue), object: nil)
                self.navigationController?.dismiss(animated: true)
            }
        }
    }

    @objc func buy() {
        let vc = TMBillingViewController()
        vc.order = order
        navigationController?.present(vc, animated: true)
    }

    @objc func confirmDelivery() {
        let orderRequest = OrderRequest(id: order.id, bills: order.bills, shippingAddress: order.shippingAddress, payment: order.payment, playerId: TMUser.user.id, createdTime: order.createdTime, payedTime: order.payedTime, state: .Done)
        TMOrderRequest.updateOrder(order: orderRequest) { _ in
            let toastView = UILabel()
            toastView.text = NSLocalizedString("确认收货成功", comment: "")
            toastView.numberOfLines = 2
            toastView.bounds = CGRect(x: 0, y: 0, width: 350, height: 150)
            toastView.backgroundColor = UIColor(named: "ComponentBackground")
            toastView.textAlignment = .center
            toastView.setCorner(radii: 15)
            self.view.showToast(toastView, duration: 1, point: CGPoint(x: self.view.bounds.width / 2, y: self.view.bounds.height / 2)) { _ in
                (self.completionHandler ?? { _ in })(self.order)
                NotificationCenter.default.post(name: Notification.Name(ToastNotification.refreshOrderData.rawValue), object: nil)
                self.navigationController?.dismiss(animated: true)
            }
        }
    }

    @objc func changeAddress() {
        let vc = TMAddressManagementViewController()
        vc.selectedCompletionHandler = { address in
            self.order.shippingAddress = address
            let orderRequest = OrderRequest(id: self.order.id, bills: self.order.bills, shippingAddress: self.order.shippingAddress, payment: self.order.payment, playerId: TMUser.user.id, createdTime: self.order.createdTime, payedTime: self.order.payedTime, state: .Done)
            TMOrderRequest.updateOrder(order: orderRequest) { _ in
                let toastView = UILabel()
                toastView.text = NSLocalizedString("修改地址成功", comment: "")
                toastView.numberOfLines = 2
                toastView.bounds = CGRect(x: 0, y: 0, width: 350, height: 150)
                toastView.backgroundColor = UIColor(named: "ComponentBackground")
                toastView.textAlignment = .center
                toastView.setCorner(radii: 15)
                self.view.showToast(toastView, duration: 1, point: CGPoint(x: self.view.bounds.width / 2, y: self.view.bounds.height / 2)) { _ in
                    self.addressView.setupEvent(address: address)
                    (self.completionHandler ?? { _ in })(self.order)
                    NotificationCenter.default.post(name: Notification.Name(ToastNotification.refreshOrderData.rawValue), object: nil)
                    self.navigationController?.dismiss(animated: true)
                }
            }
        }
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc func cancelRefund() {
        let orderRequest = OrderRequest(id: order.id, bills: order.bills, shippingAddress: order.shippingAddress, payment: order.payment, playerId: TMUser.user.id, createdTime: order.createdTime, payedTime: order.payedTime, state: .Done)
        TMOrderRequest.updateOrder(order: orderRequest) { _ in
            let toastView = UILabel()
            toastView.text = NSLocalizedString("成功取消", comment: "")
            toastView.numberOfLines = 2
            toastView.bounds = CGRect(x: 0, y: 0, width: 350, height: 150)
            toastView.backgroundColor = UIColor(named: "ComponentBackground")
            toastView.textAlignment = .center
            toastView.setCorner(radii: 15)
            self.view.showToast(toastView, duration: 1, point: CGPoint(x: self.view.bounds.width / 2, y: self.view.bounds.height / 2)) { _ in
                (self.completionHandler ?? { _ in })(self.order)
                NotificationCenter.default.post(name: Notification.Name(ToastNotification.refreshOrderData.rawValue), object: nil)
                self.navigationController?.dismiss(animated: true)
            }
        }
    }

    @objc func cancelReturn() {
        let orderRequest = OrderRequest(id: order.id, bills: order.bills, shippingAddress: order.shippingAddress, payment: order.payment, playerId: TMUser.user.id, createdTime: order.createdTime, payedTime: order.payedTime, state: .Done)
        TMOrderRequest.updateOrder(order: orderRequest) { _ in
            let toastView = UILabel()
            toastView.text = NSLocalizedString("成功取消", comment: "")
            toastView.numberOfLines = 2
            toastView.bounds = CGRect(x: 0, y: 0, width: 350, height: 150)
            toastView.backgroundColor = UIColor(named: "ComponentBackground")
            toastView.textAlignment = .center
            toastView.setCorner(radii: 15)
            self.view.showToast(toastView, duration: 1, point: CGPoint(x: self.view.bounds.width / 2, y: self.view.bounds.height / 2)) { _ in
                (self.completionHandler ?? { _ in })(self.order)
                NotificationCenter.default.post(name: Notification.Name(ToastNotification.refreshOrderData.rawValue), object: nil)
                self.navigationController?.dismiss(animated: true)
            }
        }
    }

    @objc func sentOrder() {
        let vc = TMDeliveryViewController()
        navigationController?.present(vc, animated: true)
    }
}
