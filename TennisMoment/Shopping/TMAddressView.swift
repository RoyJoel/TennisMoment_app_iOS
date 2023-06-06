//
//  TMAddressView.swift
// TennisMoment
//
//  Created by Jason Zhang on 2023/4/24.
//

import Foundation
import UIKit

class TMAddressView: UIView {
    lazy var addressLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var nameAmdSexLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var phoneNumberLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var provinceLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var cityLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var areaLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var detailedAddressLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    func setupUI() {
        backgroundColor = UIColor(named: "ComponentBackground")
        setCorner(radii: 15)
        addSubview(addressLabel)
        addSubview(nameAmdSexLabel)
        addSubview(phoneNumberLabel)
        addSubview(provinceLabel)
        addSubview(cityLabel)
        addSubview(areaLabel)
        addSubview(detailedAddressLabel)

        addressLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(24)
            make.top.equalToSuperview().offset(24)
            make.width.equalTo(158)
            make.height.equalTo(50)
        }

        nameAmdSexLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-12)
            make.left.equalToSuperview().offset(12)
            make.top.equalTo(addressLabel.snp.bottom).offset(12)
            make.height.equalToSuperview().dividedBy(7).offset(-4)
        }

        phoneNumberLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-12)
            make.left.equalToSuperview().offset(12)
            make.top.equalTo(nameAmdSexLabel.snp.bottom)
            make.height.equalToSuperview().dividedBy(7).offset(-4)
        }
        provinceLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-12)
            make.left.equalToSuperview().offset(12)
            make.top.equalTo(phoneNumberLabel.snp.bottom)
            make.height.equalToSuperview().dividedBy(7).offset(-4)
        }
        cityLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-12)
            make.left.equalToSuperview().offset(12)
            make.top.equalTo(provinceLabel.snp.bottom)
            make.height.equalToSuperview().dividedBy(7).offset(-4)
        }
        areaLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-12)
            make.left.equalToSuperview().offset(12)
            make.top.equalTo(cityLabel.snp.bottom)
            make.height.equalToSuperview().dividedBy(7).offset(-4)
        }
        detailedAddressLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-12)
            make.left.equalToSuperview().offset(12)
            make.top.equalTo(areaLabel.snp.bottom)
            make.height.equalToSuperview().dividedBy(7).offset(-4)
        }

        addressLabel.text = "Delivery Address"
        nameAmdSexLabel.textAlignment = .right
        phoneNumberLabel.textAlignment = .right
        provinceLabel.textAlignment = .right
        cityLabel.textAlignment = .right
        areaLabel.textAlignment = .right
        detailedAddressLabel.textAlignment = .right
        detailedAddressLabel.numberOfLines = 2
        addTapGesture(self, #selector(editAddress))
    }

    func setupEvent(address: Address) {
        nameAmdSexLabel.text = "\(address.name) \(address.sex == .Man ? "先生" : "女士")"
        phoneNumberLabel.text = "\(address.phoneNumber)"
        provinceLabel.text = "\(address.province)"
        cityLabel.text = "\(address.city)"
        areaLabel.text = "\(address.area)"
        detailedAddressLabel.text = "\(address.detailedAddress)"
    }

    @objc func editAddress() {
        let vc = TMAddressManagementViewController()
        if let parentVC = getParentViewController() {
            vc.selectedCompletionHandler = { address in
                self.setupEvent(address: address)
            }
            parentVC.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
