//
//  TMBillTableViewController.swift
//  TMMS
//
//  Created by Jason Zhang on 2023/4/24.
//

import Foundation
import UIKit

class TMBillTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var bills: [Bill] = []

    lazy var orderBackgroundView: UIView = {
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

    lazy var billTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()

    lazy var alartView: UILabel = {
        let label = UILabel()
        return label
    }()

    override func viewDidLoad() {
        view.backgroundColor = UIColor(named: "BackgroundGray")
        view.addSubview(billTableView)
        view.addSubview(alartView)
        billTableView.backgroundColor = UIColor(named: "BackgroundGray")
        view.insertSubview(orderBackgroundView, aboveSubview: billTableView)
        orderBackgroundView.addSubview(totalLabel)
        orderBackgroundView.addSubview(totalNumLabel)
        orderBackgroundView.addSubview(confirmBtn)

        billTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        orderBackgroundView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(208)
        }

        totalLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(24)
            make.top.equalToSuperview().offset(24)
            make.height.equalTo(50)
        }

        totalNumLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-24)
            make.top.equalToSuperview().offset(24)
            make.height.equalTo(50)
        }

        confirmBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-24)
            make.bottom.equalToSuperview().offset(-24)
            make.width.equalTo(108)
            make.height.equalTo(50)
        }

        alartView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        billTableView.register(TMComBillingCell.self, forCellReuseIdentifier: "billing")
        billTableView.showsHorizontalScrollIndicator = false
        billTableView.showsVerticalScrollIndicator = false
        billTableView.dataSource = self
        billTableView.delegate = self

        orderBackgroundView.backgroundColor = UIColor(named: "ComponentBackground")
        orderBackgroundView.isHidden = true
        billTableView.isHidden = false
        alartView.isHidden = true
    }

    func setupAlart() {
        orderBackgroundView.isHidden = true
        billTableView.isHidden = true
        alartView.isHidden = false
        alartView.text = NSLocalizedString("空空如也", comment: "")
        alartView.font = UIFont.systemFont(ofSize: 22)
        alartView.textAlignment = .center
    }

    func openCartMode() {
        title = "购物车"
        TMUser.getCartInfo { cart in
            if cart.bills.count == 0 {
                self.setupAlart()
            } else {
                self.bills = cart.bills
                self.billTableView.reloadData()
                self.totalLabel.text = "Total"
                self.totalLabel.font = UIFont.systemFont(ofSize: 26)

                let totalNum = TMDataConvert.getTotalPrice(cart.bills)
                self.totalNumLabel.text = "¥" + String(format: "%.2f", totalNum)
                self.totalNumLabel.font = UIFont.systemFont(ofSize: 22)

                self.confirmBtn.setTitle("下单", for: .normal)
                self.confirmBtn.backgroundColor = UIColor(named: "TennisBlur")
                self.confirmBtn.setTitleColor(.black, for: .normal)
                self.confirmBtn.addTarget(self, action: #selector(self.enterBillingViewController), for: .touchDown)
                self.confirmBtn.setCorner(radii: 15)
                self.orderBackgroundView.isHidden = false
            }
        }
    }

    func tableView(_: UITableView, canEditRowAt _: IndexPath) -> Bool {
        if title == "购物车" {
            return true
        } else {
            return false
        }
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt _: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    func tableView(_: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: NSLocalizedString("Delete", comment: "")) { _, _, _ in
            let bill = self.bills.remove(at: indexPath.row)
            let billRequest = BillRequest(id: bill.id, comId: bill.com.id, quantity: bill.quantity, optionId: bill.option.id, orderId: TMUser.user.cart)
            TMUser.deleteBillInCart(bill: billRequest) { cart in
                self.bills = cart.bills
                self.billTableView.reloadData()
                let toastView = UILabel()
                toastView.text = NSLocalizedString("已删除", comment: "")
                toastView.numberOfLines = 2
                toastView.bounds = CGRect(x: 0, y: 0, width: 350, height: 150)
                toastView.backgroundColor = UIColor(named: "ComponentBackground")
                toastView.textAlignment = .center
                toastView.setCorner(radii: 15)
                self.view.showToast(toastView, duration: 1, point: CGPoint(x: self.view.bounds.width / 2, y: self.view.bounds.height / 2)) { _ in
                }
            }
        }
        deleteAction.backgroundColor = .red
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return bills.count
    }

    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return 118
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TMComBillingCell()
        cell.setupEvent(bill: bills[indexPath.row])
        return cell
    }

    @objc func enterBillingViewController() {
        let vc = TMBillingViewController()
        let newOrder = Order(id: 0, bills: bills, shippingAddress: TMUser.user.defaultAddress, payment: .weChatOnline, createdTime: Date().timeIntervalSince1970, state: .ToPay)
        vc.order = newOrder
        navigationController?.pushViewController(vc, animated: true)
        vc.isCart = true
    }
}
