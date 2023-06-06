//
//  TMBillingView.swift
//  TMMS
//
//  Created by Jason Zhang on 2023/4/24.
//

import Foundation
import UIKit

class TMBillingView: UIView {
    private var bills: [Bill] = []
    var isOrderCell: Bool = false
    func setup(with bills: [Bill]) {
        self.bills = bills
        if bills.count == 1 {
            if isOrderCell {
                let imageView = UIImageView()
                addSubview(imageView)
                imageView.snp.makeConstraints { make in
                    make.left.equalToSuperview()
                    make.top.equalToSuperview().offset(12)
                    make.bottom.equalToSuperview().offset(-12)
                    make.width.equalTo(imageView.snp.height)
                }
                imageView.image = UIImage(data: bills[0].option.image.toPng())
                imageView.setCorner(radii: 15)
                var lastView = imageView
                for bill in 1 ..< min(5, bills.count) {
                    let imageView = UIImageView()
                    addSubview(imageView)
                    imageView.snp.makeConstraints { make in
                        make.left.equalTo(lastView.snp.right).offset(6)
                        make.top.equalToSuperview().offset(12)
                        make.bottom.equalToSuperview().offset(-12)
                        make.width.equalTo(imageView.snp.height)
                    }
                    imageView.image = UIImage(data: bills[bill].option.image.toPng())
                    imageView.setCorner(radii: 15)
                    lastView = imageView
                }

                let countLabel = UILabel()
                addSubview(countLabel)
                countLabel.snp.makeConstraints { make in
                    make.right.equalToSuperview().offset(-12)
                    make.top.equalToSuperview().offset(12)
                    make.bottom.equalToSuperview().offset(-12)
                    make.right.equalToSuperview()
                }
                countLabel.text = "共\(bills.count)种商品"

                addTapGesture(self, #selector(enterCountView))
            } else {
                let billView = TMComBillingCell()
                addSubview(billView)
                billView.snp.makeConstraints { make in
                    make.edges.equalToSuperview()
                }
                billView.setupEvent(bill: bills[0])
            }
        } else if bills.count == 2 {
            if isOrderCell {
                let imageView = UIImageView()
                addSubview(imageView)
                imageView.snp.makeConstraints { make in
                    make.left.equalToSuperview()
                    make.top.equalToSuperview().offset(12)
                    make.bottom.equalToSuperview().offset(-12)
                    make.width.equalTo(imageView.snp.height)
                }
                imageView.image = UIImage(data: bills[0].option.image.toPng())
                imageView.setCorner(radii: 15)
                var lastView = imageView
                for bill in 1 ..< min(5, bills.count) {
                    let imageView = UIImageView()
                    addSubview(imageView)
                    imageView.snp.makeConstraints { make in
                        make.left.equalTo(lastView.snp.right).offset(6)
                        make.top.equalToSuperview().offset(12)
                        make.bottom.equalToSuperview().offset(-12)
                        make.width.equalTo(imageView.snp.height)
                    }
                    imageView.image = UIImage(data: bills[bill].option.image.toPng())
                    imageView.setCorner(radii: 15)
                    lastView = imageView
                }

                let countLabel = UILabel()
                addSubview(countLabel)
                countLabel.snp.makeConstraints { make in
                    make.right.equalToSuperview().offset(-12)
                    make.top.equalToSuperview().offset(12)
                    make.bottom.equalToSuperview().offset(-12)
                    make.right.equalToSuperview()
                }
                countLabel.text = "共\(bills.count)种商品"

                addTapGesture(self, #selector(enterCountView))
            } else {
                let billView = TMComBillingCell()
                addSubview(billView)
                billView.snp.makeConstraints { make in
                    make.left.top.bottom.equalToSuperview()
                    make.width.equalToSuperview().dividedBy(2).offset(6)
                }
                let additionalView = TMComBillingCell()
                addSubview(additionalView)
                additionalView.snp.makeConstraints { make in
                    make.right.top.bottom.equalToSuperview()
                    make.left.equalTo(billView.snp.right).offset(6)
                }
                billView.setupEvent(bill: bills[0])
                additionalView.setupEvent(bill: bills[1])
            }
        } else if bills.count >= 3 {
            let imageView = UIImageView()
            addSubview(imageView)
            imageView.snp.makeConstraints { make in
                make.left.equalToSuperview()
                make.top.equalToSuperview().offset(12)
                make.bottom.equalToSuperview().offset(-12)
                make.width.equalTo(imageView.snp.height)
            }
            imageView.image = UIImage(data: bills[0].option.image.toPng())
            imageView.setCorner(radii: 15)
            var lastView = imageView
            for bill in 1 ..< min(5, bills.count) {
                let imageView = UIImageView()
                addSubview(imageView)
                imageView.snp.makeConstraints { make in
                    make.left.equalTo(lastView.snp.right).offset(6)
                    make.top.equalToSuperview().offset(12)
                    make.bottom.equalToSuperview().offset(-12)
                    make.width.equalTo(imageView.snp.height)
                }
                imageView.image = UIImage(data: bills[bill].option.image.toPng())
                imageView.setCorner(radii: 15)
                lastView = imageView
            }

            let countLabel = UILabel()
            addSubview(countLabel)
            countLabel.snp.makeConstraints { make in
                make.right.equalToSuperview().offset(-12)
                make.top.equalToSuperview().offset(12)
                make.bottom.equalToSuperview().offset(-12)
                make.right.equalToSuperview()
            }
            countLabel.text = "共\(bills.count)种商品"

            addTapGesture(self, #selector(enterCountView))
        }
    }

    @objc func enterCountView() {
        let vc = TMBillTableViewController()
        vc.bills = bills
        if let parentVC = getParentViewController() {
            parentVC.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
