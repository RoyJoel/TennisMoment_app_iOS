//
//  BasinessComponent.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2022/12/27.
//

import Foundation
import SnapKit
import UIKit

/// 基本信息视图，使用时需设置宽高，图片大小将随之变化
open class TMIconView: TMView {
    public var config = TMIconViewConfig(icon: Data(), name: "")

    private lazy var iconImage: UIImageView = {
        var image = UIImageView()
        image.setCorner(radii: 15)
        image.drawBorder(color: .white, width: 5)
        return image
    }()

    private lazy var nameView: UILabel = {
        var view = UILabel()
        return view
    }()

    public func setup(with config: TMIconViewConfig) {
        self.config = config

        setupUI()
        setupEvent(config: config)
    }

    public func setupUI() {
        clipsToBounds = false
        addSubview(iconImage)
        addSubview(nameView)

        nameView.isHidden = false
        iconImage.contentMode = .scaleAspectFill

        iconImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
            make.width.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(8)
        }
        nameView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-8)
            make.top.equalTo(iconImage.snp.bottom).offset(8)
            make.height.equalTo(30)
            make.centerX.equalTo(self.iconImage.snp.centerX)
        }
        iconImage.isUserInteractionEnabled = true
        nameView.isUserInteractionEnabled = true
    }

    public func setupEvent(config: TMIconViewConfig) {
        iconImage.image = UIImage(data: config.icon)
        if config.name == "" {
            nameView.isHidden = true
        } else {
            nameView.isHidden = false
            nameView.text = config.name
        }
    }

    public func updateInfo(with icon: Data, named name: String) {
        config.icon = icon
        config.name = name
        iconImage.image = UIImage(data: config.icon)
        if config.name == "" {
            nameView.isHidden = true
        } else {
            nameView.isHidden = false
            nameView.text = config.name
        }
    }

    public override func scaleTo(_ isEnlarge: Bool) {
        super.scaleTo(isEnlarge)
//        UIView.animate(withDuration: 0.3) {
//            self.iconImage.snp.updateConstraints { make in
//                make.centerX.equalToSuperview()
//                make.left.equalToSuperview().offset(8)
//                make.right.equalToSuperview().offset(-8)
//                make.width.equalToSuperview().offset(-16)
//                make.height.equalToSuperview().offset(-16)
//                make.top.equalToSuperview().offset(8)
//                make.bottom.equalTo(self.nameView.snp.top).offset(-8)
//            }
//            self.nameView.snp.updateConstraints { make in
//                make.bottom.equalToSuperview().offset(-8)
//                make.top.equalTo(self.iconImage.snp.bottom).offset(8)
//                make.centerX.equalTo(self.iconImage.snp.centerX)
//            }
//        }
//        addGroupAnimation(with: [iconImage,nameView], isEnlarge: isEnlarge)
    }

//    override func didScaleTo(_ isEnlarge: Bool) {
//        super.didScaleTo(isEnlarge)
//        print(iconImage.layer.position)
//        print(iconImage.layer.bounds)
    ////        iconImage.scaleTo(isEnlarge)
    ////        nameView.scaleTo(isEnlarge)
//    }
}
