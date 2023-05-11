//
//  TMSettingUserIconCell.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/3/30.
//

import Foundation
import UIKit

class TMSettingUserIconCell: UITableViewCell {
    lazy var titleView: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var iconView: UIImageView = {
        let image = UIImageView()
        return image
    }()

    lazy var navigationBar: UIImageView = {
        let image = UIImageView()
        return image
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor(named: "BackgroundGray")
        contentView.addSubview(titleView)
        contentView.addSubview(iconView)
        contentView.addSubview(navigationBar)
        layoutSubviews()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        titleView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(24)
            make.width.equalTo(188)
        }
        navigationBar.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(35)
            make.bottom.equalToSuperview().offset(-35)
            make.right.equalToSuperview().offset(-24)
            make.width.equalTo(25)
        }
        iconView.snp.makeConstraints { make in
            make.right.equalTo(navigationBar.snp.left)
            make.top.equalToSuperview().offset(12)
            make.bottom.equalToSuperview().offset(-12)
            make.width.equalTo(74)
        }
        navigationBar.image = UIImage(systemName: "chevron.forward")
        titleView.font = UIFont.systemFont(ofSize: 20)
        iconView.contentMode = .scaleAspectFill
        iconView.setCorner(radii: 15)
    }

    func setupEvent(title: String, icon: Data) {
        titleView.text = title
        iconView.image = UIImage(data: icon)
    }
}
