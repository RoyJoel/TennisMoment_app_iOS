//
//  TMWinnerToastView.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/2/24.
//

import Foundation
import UIKit

class TMWinnerToastView: UIView {
    lazy var iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "TennisBall")
        imageView.setCorner(radii: 85)
        return imageView
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 26)
        return label
    }()

    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 26)
        return label
    }()

    func setupUI(_ winner: String) {
        bounds = CGRect(x: 0, y: 0, width: 300, height: 300)
        backgroundColor = .white
        setCorner(radii: 15)
        titleLabel.text = NSLocalizedString("GAME SET AND MATCH", comment: "")
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 1

        nameLabel.text = "\(winner)"
        nameLabel.textAlignment = .center
        nameLabel.numberOfLines = 1

        addSubview(iconView)
        addSubview(titleLabel)
        addSubview(nameLabel)

        iconView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-45)
            make.width.equalTo(170)
            make.height.equalTo(170)
        }

        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(70)
            make.width.equalTo(260)
            make.height.equalTo(40)
        }
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(110)
            make.width.equalTo(260)
            make.height.equalTo(40)
        }
    }
}
