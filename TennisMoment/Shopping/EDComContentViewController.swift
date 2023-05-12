//
//  EDComContentViewController.swift
//  EDMS
//
//  Created by Jason Zhang on 2023/4/22.
//

import Foundation
import TMComponent
import UIKit

class TMComContentViewController: UIViewController {
    var com: Commodity = Commodity()

    lazy var imagesView: TMComImagesView = {
        let view = TMComImagesView()
        return view
    }()

    lazy var nameView: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var introView: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var priceView: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var buyBtn: TMButton = {
        let btn = TMButton()
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = UIColor(named: "ContentBackground")
        view.backgroundColor = UIColor(named: "BackgroundGray")
        view.addSubview(imagesView)
        view.addSubview(nameView)
        view.addSubview(priceView)
        view.addSubview(introView)
        view.addSubview(buyBtn)

        imagesView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(36)
            make.centerY.equalToSuperview()
            make.width.equalTo(UIStandard.shared.screenWidth * 0.5)
            make.height.equalTo(UIStandard.shared.screenWidth * 0.5)
        }
        imagesView.intros = com.images
        imagesView.setupUI()

        nameView.snp.makeConstraints { make in
            make.top.equalTo(imagesView.snp.top)
            make.right.equalToSuperview().offset(-36)
            make.width.equalTo(UIStandard.shared.screenWidth * 0.4)
        }

        nameView.font = UIFont.systemFont(ofSize: 36)
        nameView.numberOfLines = 2
        nameView.text = com.name
        priceView.snp.makeConstraints { make in
            make.top.equalTo(nameView.snp.bottom).offset(12)
            make.left.equalTo(nameView.snp.left)
            make.height.equalTo(50)
        }

        priceView.font = UIFont.systemFont(ofSize: 28)
        priceView.text = "¥" + String(format: "%.2f", com.price)

        introView.snp.makeConstraints { make in
            make.top.equalTo(priceView.snp.bottom).offset(12)
            make.right.equalTo(nameView.snp.right).offset(-24)
            make.left.equalTo(nameView.snp.left)
        }

        introView.font = UIFont.systemFont(ofSize: 20)
        introView.numberOfLines = 50
        introView.text = com.intro

        buyBtn.snp.makeConstraints { make in
            make.bottom.equalTo(imagesView.snp.bottom)
            make.right.equalTo(nameView.snp.right)
            make.width.equalTo(144)
            make.height.equalTo(50)
        }

        let btnConfig = TMButtonConfig(title: "Want This?", action: #selector(selectConfig), actionTarget: self)
        buyBtn.setUp(with: btnConfig)
        buyBtn.backgroundColor = UIColor(named: "TennisBlur")
        buyBtn.setTitleColor(.black, for: .normal)
    }

    @objc func selectConfig() {
        let vc = TMConfigSelectionViewController()
        vc.com = com
        let navVC = UINavigationController(rootViewController: vc)
        present(navVC, animated: true)
    }
}
