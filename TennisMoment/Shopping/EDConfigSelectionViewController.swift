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

    lazy var shoppingCollectionView: TMSelectionCollectionView = {
        let view = TMSelectionCollectionView(frame: .zero, collectionViewLayout: TMCagCollectionViewLayout(itemCount: com.images.count), com: com)
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
        view.addSubview(shoppingCollectionView)
        view.addSubview(quantityLabel)
        view.addSubview(quantityView)
        view.addSubview(buyBtn)
        view.addSubview(addToCartBtn)

        shoppingCollectionView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(24)
            make.bottom.equalTo(quantityLabel.snp.top).offset(-68)
            make.right.equalToSuperview().offset(-24)
            make.height.equalTo(132)
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
            make.centerX.equalToSuperview().offset(178)
            make.width.equalTo(144)
            make.height.equalTo(50)
        }

        addToCartBtn.snp.makeConstraints { make in
            make.top.equalTo(quantityLabel.snp.bottom).offset(68)
            make.centerX.equalToSuperview().offset(-178)
            make.width.equalTo(144)
            make.height.equalTo(50)
        }

        quantityLabel.text = "数量"
        quantityView.setupUI(maximumQuantity: com.limit)

        let buyBtnConfig = TMButtonConfig(title: "Buy Now", action: #selector(selectConfig), actionTarget: self)
        buyBtn.setUp(with: buyBtnConfig)
        buyBtn.backgroundColor = UIColor(named: "TennisBlur")
        buyBtn.setTitleColor(.black, for: .normal)

        let cartBtnConfig = TMButtonConfig(title: "Add To Cart", action: #selector(selectConfig), actionTarget: self)
        addToCartBtn.setUp(with: cartBtnConfig)
        addToCartBtn.backgroundColor = UIColor(named: "TennisBlur")
        addToCartBtn.setTitleColor(.black, for: .normal)
    }

    @objc func selectConfig() {
        let vc = TMBillingViewController()
        vc.order = order
        navigationController?.pushViewController(vc, animated: true)
    }
}
