//
//  TMTitleOrImageButton.swift
//  TMComponent
//
//  Created by Jason Zhang on 2023/3/2.
//

import Foundation
import UIKit

open class TMTitleOrImageButton: UIButton {
    public var config = TMTitleOrImageButtonConfig(action: #selector(method), actionTarget: TMTitleOrImageButton.self)

    private lazy var optionalImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.setCorner(radii: 15)
        return imageView
    }()

    private lazy var optionalTitleLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    public func setUp(with config: TMTitleOrImageButtonConfig) {
        setupUI()
        setupEvent(config: config)
    }

    private func setupUI() {
        setTitleColor(UIColor(named: "ContentBackground"), for: .normal)
        setTitleColor(UIColor(named: "TennisBlur"), for: .selected)
        backgroundColor = UIColor(named: "ComponentBackground")
        titleLabel?.numberOfLines = 2
        titleLabel?.textAlignment = .center
        setCorner(radii: 15)

        addSubview(optionalImageView)
        addSubview(optionalTitleLabel)

        optionalTitleLabel.numberOfLines = 1
        optionalTitleLabel.textAlignment = .center

        optionalImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-12)
            make.height.equalTo(30)
        }
        optionalTitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-30)
            make.height.equalTo(30)
        }
        optionalImageView.isHidden = true
        optionalTitleLabel.isHidden = true
    }

    private func setupEvent(config: TMTitleOrImageButtonConfig) {
        self.config = config
        addTapGesture(config.actionTarget, config.action)

        if let image = config.image {
            optionalImageView.isHidden = false
            optionalTitleLabel.isHidden = true

            optionalImageView.image = image

            optionalImageView.snp.remakeConstraints { make in
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview()
                make.width.equalTo(bounds.width * 0.6)
                make.height.equalTo(bounds.height * 0.6)
            }
        } else {
            optionalImageView.isHidden = true
            if let title = config.title {
                optionalTitleLabel.isHidden = false

                optionalTitleLabel.text = title

                optionalTitleLabel.snp.remakeConstraints { make in
                    make.centerX.equalToSuperview()
                    make.centerY.equalToSuperview()
                    make.width.equalTo(bounds.width * 0.6)
                    make.height.equalTo(bounds.height * 0.6)
                }
            } else {
                optionalTitleLabel.isHidden = true
            }
        }
    }
}
