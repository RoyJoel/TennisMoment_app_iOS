//
//  TMVSView.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/2/17.
//

import Foundation
import UIKit

/// TM双方得分视图，使用时仅需设置宽度
open class TMPointComparingView: TMView {
    private lazy var titleView: UILabel = {
        let label = UILabel()
        return label
    }()

    private lazy var leftPointView: TMBasicPointView = {
        let pointView = TMBasicPointView()
        return pointView
    }()

    private lazy var rightPointView: TMBasicPointView = {
        let pointView = TMBasicPointView()
        return pointView
    }()

    public func setup(with config: TMPointComparingViewConfig) {
        setupUI()
        setupEvent(config: config)
    }

    public func updateLeftViewData(isServingOnLeft: Bool, newNum: String) {
        leftPointView.updateView(isServing: isServingOnLeft, newNum: newNum)
    }

    public func updateRightViewData(isServingOnRight: Bool, newNum: String) {
        rightPointView.updateView(isServing: isServingOnRight, newNum: newNum)
    }

    private func setupUI() {
        addSubview(titleView)
        addSubview(leftPointView)
        addSubview(rightPointView)

        leftPointView.snp.makeConstraints { make in
            make.left.equalToSuperview()
        }
        rightPointView.snp.makeConstraints { make in
            make.right.equalToSuperview()
        }

        titleView.isHidden = true
    }

    private func setupEvent(config: TMPointComparingViewConfig) {
        titleView.font = config.font

        if config.isComparing {
            if config.areBothServing {
                leftPointView.setup(with: TMBasicPointViewConfig(isLeft: true, iconName: config.iconName, isServing: true, num: config.leftNum, font: config.font))
                rightPointView.setup(with: TMBasicPointViewConfig(isLeft: false, iconName: config.iconName, isServing: true, num: config.rightNum, font: config.font))
            } else {
                leftPointView.setup(with: TMBasicPointViewConfig(isLeft: true, iconName: config.iconName, isServing: config.isServingOnLeft, num: config.leftNum, font: config.font))
                rightPointView.setup(with: TMBasicPointViewConfig(isLeft: false, iconName: config.iconName, isServing: !config.isServingOnLeft, num: config.rightNum, font: config.font))
            }
        } else {
            leftPointView.setup(with: TMBasicPointViewConfig(isLeft: true, iconName: config.iconName, isServing: false, num: config.leftNum, font: config.font))
            rightPointView.setup(with: TMBasicPointViewConfig(isLeft: false, iconName: config.iconName, isServing: false, num: config.rightNum, font: config.font))
        }

        let label = UILabel()
        label.text = "height estimation"
        label.font = config.font
        label.sizeToFit()
        let TMBPViewHeight = label.bounds.size.height

        if config.title != nil {
            if !config.isTitleHidden {
                titleView.text = config.title
                titleView.isHidden = false

                if config.isTitleViewAbovePointView {
                    titleView.snp.remakeConstraints { make in
                        make.top.equalToSuperview()
                        make.centerX.equalToSuperview()
                    }
                    leftPointView.snp.remakeConstraints { make in
                        make.left.equalToSuperview()
                        make.bottom.equalToSuperview()
                        make.height.equalTo(TMBPViewHeight)
                    }
                    rightPointView.snp.remakeConstraints { make in
                        make.right.equalToSuperview()
                        make.bottom.equalToSuperview()
                        make.height.equalTo(TMBPViewHeight)
                    }
                } else {
                    titleView.snp.remakeConstraints { make in
                        make.centerX.equalToSuperview()
                        make.centerY.equalToSuperview()
                    }
                    leftPointView.snp.remakeConstraints { make in
                        make.left.equalToSuperview()
                        make.centerY.equalToSuperview()
                        make.height.equalTo(TMBPViewHeight)
                    }
                    rightPointView.snp.remakeConstraints { make in
                        make.right.equalToSuperview()
                        make.centerY.equalToSuperview()
                        make.height.equalTo(TMBPViewHeight)
                    }
                }
            } else {
                titleView.isHidden = true

                leftPointView.snp.remakeConstraints { make in
                    make.left.equalToSuperview()
                    make.centerY.equalToSuperview()
                    make.height.equalTo(TMBPViewHeight)
                }
                rightPointView.snp.remakeConstraints { make in
                    make.right.equalToSuperview()
                    make.centerY.equalToSuperview()
                    make.height.equalTo(TMBPViewHeight)
                }
            }
        } else {
            titleView.isHidden = true

            leftPointView.snp.remakeConstraints { make in
                make.left.equalToSuperview()
                make.centerY.equalToSuperview()
                make.height.equalTo(TMBPViewHeight)
            }
            rightPointView.snp.remakeConstraints { make in
                make.right.equalToSuperview()
                make.centerY.equalToSuperview()
                make.height.equalTo(TMBPViewHeight)
            }
        }
    }
}
