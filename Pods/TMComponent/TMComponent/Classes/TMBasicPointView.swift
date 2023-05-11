//
//  TMBasicPointView.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/2/17.
//

import Foundation
import UIKit

/// TM基础分数视图
open class TMBasicPointView: TMView {
    private lazy var highLightImage: UIImageView = {
        let imageView = UIImageView()
        imageView.setCorner(radii: 10)
        return imageView
    }()

    private lazy var pointLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    public func setup(with config: TMBasicPointViewConfig) {
        setupUI()
        setupEvent(config: config)
    }

    public func updateView(isServing: Bool, newNum: String) {
        if !isServing {
            highLightImage.isHidden = true
        } else {
            highLightImage.isHidden = false
        }
        pointLabel.text = newNum
    }

    private func setupUI() {
        addSubview(highLightImage)
        addSubview(pointLabel)
        highLightImage.snp.makeConstraints { make in
            make.centerY.equalTo(pointLabel.snp.centerY)
            make.left.equalToSuperview()
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        pointLabel.snp.makeConstraints { make in
            make.left.equalTo(highLightImage.snp.right).offset(8)
            make.centerY.equalToSuperview()
        }
    }

    private func setupEvent(config: TMBasicPointViewConfig) {
        if let iconImage = config.iconName {
            highLightImage.image = UIImage(named: iconImage)
            highLightImage.isHidden = false
        } else {
            highLightImage.isHidden = true
        }
        if !config.isServing {
            highLightImage.isHidden = true
            if !config.isLeft {
                pointLabel.snp.remakeConstraints { make in
                    make.right.equalToSuperview().offset(-28)
                    make.centerY.equalToSuperview()
                }
            } else {
                pointLabel.snp.remakeConstraints { make in
                    make.left.equalToSuperview().offset(28)
                    make.centerY.equalToSuperview()
                }
            }
        } else {
            highLightImage.isHidden = false
            if !config.isLeft {
                highLightImage.snp.remakeConstraints { make in
                    make.centerY.equalTo(pointLabel.snp.centerY)
                    make.right.equalToSuperview()
                    make.width.equalTo(20)
                    make.height.equalTo(20)
                }
                pointLabel.snp.remakeConstraints { make in
                    make.right.equalTo(highLightImage.snp.left).offset(-8)
                    make.centerY.equalToSuperview()
                }
            } else {
                highLightImage.snp.remakeConstraints { make in
                    make.centerY.equalTo(pointLabel.snp.centerY)
                    make.left.equalToSuperview()
                    make.width.equalTo(20)
                    make.height.equalTo(20)
                }
                pointLabel.snp.remakeConstraints { make in
                    make.left.equalTo(highLightImage.snp.right).offset(8)
                    make.centerY.equalToSuperview()
                }
            }
        }
        pointLabel.text = config.num
        pointLabel.font = config.font
    }
}
