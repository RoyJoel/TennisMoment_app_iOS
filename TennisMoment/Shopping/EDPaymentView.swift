//
//  EDPaymentView.swift
//  EDMS
//
//  Created by Jason Zhang on 2023/4/27.
//
import Foundation
import TMComponent
import UIKit

class TMPaymentView: UIView, UITableViewDataSource {
    var paymentConfig = Payment.allCases.compactMap { $0.rawValue }

    lazy var titleView: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var paymentSelectionView: TMPopUpView = {
        let view = TMPopUpView()
        return view
    }()

    func setupUI() {
        backgroundColor = UIColor(named: "BackgroundGray")
        addSubview(titleView)
        addSubview(paymentSelectionView)
        titleView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(24)
            make.width.equalTo(108)
        }
        paymentSelectionView.frame = CGRect(x: bounds.width - 122, y: 12, width: 98, height: bounds.height - 24)

        titleView.font = UIFont.systemFont(ofSize: 20)
        paymentSelectionView.dataSource = self
        paymentSelectionView.delegate = paymentSelectionView
        paymentSelectionView.setupUI()
        paymentSelectionView.selectedCompletionHandler = { indexPath in
            let selectedPayment = self.paymentConfig.remove(at: indexPath)
            self.paymentConfig.insert(selectedPayment, at: 0)
            self.paymentSelectionView.reloadData()
        }
    }

    func setupEvent(title: String, info _: String) {
        titleView.text = title
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        paymentConfig.count
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TMPopUpCell()
        cell.setupUI()
        cell.setupEvent(title: paymentConfig[indexPath.row])
        return cell
    }
}
