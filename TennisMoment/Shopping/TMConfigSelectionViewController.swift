//
//  TMConfigSelectionViewController.swift
//  TMMS
//
//  Created by Jason Zhang on 2023/4/22.
//

import Foundation
import TMComponent
import UIKit

class TMConfigSelectionViewController: UIViewController {
    var com: Commodity = Commodity()

    lazy var configLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var shoppingCollectionView: TMSelectionCollectionView = {
        let view = TMSelectionCollectionView(frame: .zero, collectionViewLayout: TMCagCollectionViewLayout(itemCount: com.options.count), com: com)
        return view
    }()

    lazy var quantityLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var quantityView: TMQuantitySelectorView = {
        let view = TMQuantitySelectorView()
        return view
    }()

    lazy var addToCartBtn: TMButton = {
        let btn = TMButton()
        return btn
    }()

    lazy var buyBtn: TMButton = {
        let btn = TMButton()
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = UIColor(named: "ContentBackground")
        view.backgroundColor = UIColor(named: "BackgroundGray")
        view.addSubview(configLabel)
        view.addSubview(shoppingCollectionView)
        view.addSubview(quantityLabel)
        view.addSubview(quantityView)
        view.addSubview(buyBtn)
        view.addSubview(addToCartBtn)

        configLabel.snp.makeConstraints { make in
            make.bottom.equalTo(shoppingCollectionView.snp.top).offset(-24)
            make.height.equalTo(30)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
        }

        shoppingCollectionView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(24)
            make.bottom.equalTo(quantityLabel.snp.top).offset(-24)
            make.right.equalToSuperview().offset(-24)
            make.height.equalTo(220)
        }

        quantityLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(24)
            make.centerY.equalToSuperview()
            make.width.equalTo(88)
            make.height.equalTo(50)
        }

        quantityView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-24)
            make.height.equalTo(50)
            make.width.equalTo(200)
            make.centerY.equalToSuperview()
        }

        buyBtn.snp.makeConstraints { make in
            make.top.equalTo(quantityLabel.snp.bottom).offset(68)
            make.centerX.equalToSuperview().offset(84)
            make.width.equalTo(144)
            make.height.equalTo(50)
        }

        addToCartBtn.snp.makeConstraints { make in
            make.top.equalTo(quantityLabel.snp.bottom).offset(68)
            make.centerX.equalToSuperview().offset(-84)
            make.width.equalTo(144)
            make.height.equalTo(50)
        }

        configLabel.text = "已选\(com.options[0].intro)"

        shoppingCollectionView.selectedCompletionHandler = { option in
            self.configLabel.text = "已选\(option.intro)"
        }

        quantityLabel.text = "数量"
        quantityView.setupUI(maximumQuantity: TMDataConvert.getTotalInventory(with: com.options))

        let buyBtnConfig = TMButtonConfig(title: "立即购买", action: #selector(addOrder), actionTarget: self)
        buyBtn.setUp(with: buyBtnConfig)
        buyBtn.backgroundColor = UIColor(named: "TennisBlur")
        buyBtn.setTitleColor(.black, for: .normal)

        let cartBtnConfig = TMButtonConfig(title: "添加到购物车", action: #selector(addToCart), actionTarget: self)
        addToCartBtn.setUp(with: cartBtnConfig)
        addToCartBtn.backgroundColor = UIColor(named: "TennisBlur")
        addToCartBtn.setTitleColor(.black, for: .normal)
    }

    @objc func addOrder() {
        let vc = TMBillingViewController()
        let bill = Bill(id: 0, com: com, quantity: quantityView.currentQuantity, option: com.options[shoppingCollectionView.selectedRow])
        let order = Order(id: 0, bills: [bill], shippingAddress: TMUser.user.defaultAddress, payment: .weChatOnline, createdTime: Date().timeIntervalSince1970, state: .ToPay)
        vc.order = order
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc func addToCart() {
        let newBill = BillRequest(id: 0, comId: com.id, quantity: quantityView.currentQuantity, optionId: com.options[shoppingCollectionView.selectedRow].id, orderId: TMUser.user.cart)
        TMUser.addToCart(bill: newBill) { _ in
            let toastView = UILabel()
            toastView.text = NSLocalizedString("已添加到购物车", comment: "")
            toastView.numberOfLines = 2
            toastView.bounds = CGRect(x: 0, y: 0, width: 350, height: 150)
            toastView.backgroundColor = UIColor(named: "ComponentBackground")
            toastView.textAlignment = .center
            toastView.setCorner(radii: 15)
            self.view.showToast(toastView, duration: 1, point: CGPoint(x: self.view.bounds.width / 2, y: self.view.bounds.height / 2)) { _ in
            }
        }
    }
}
