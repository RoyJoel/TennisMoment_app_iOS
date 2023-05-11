//
//  TMSettingIconCell.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/3/30.
//

import Foundation
import UIKit

class TMSettingIconCell: UITableViewCell {
    lazy var titleView: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var iconView: UIImageView = {
        let image = UIImageView()
        return image
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor(named: "BackgroundGray")
        contentView.addSubview(titleView)
        contentView.addSubview(iconView)
        layoutSubviews()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        titleView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-12)
            make.left.right.equalToSuperview()
            make.height.equalTo(44)
        }
        iconView.snp.makeConstraints { make in
            make.bottom.equalTo(titleView.snp.top)
            make.top.equalToSuperview().offset(68)
            make.centerX.equalToSuperview()
            make.width.equalTo(218)
        }
        titleView.font = UIFont.systemFont(ofSize: 38)
        titleView.text = "Tennis Moment"
        titleView.textAlignment = .center
        titleView.textColor = UIColor(named: "ContentBackground")
        iconView.image = UIImage(named: "TennisBall")
        iconView.contentMode = .scaleToFill
        iconView.setCorner(radii: 15)
    }
}
