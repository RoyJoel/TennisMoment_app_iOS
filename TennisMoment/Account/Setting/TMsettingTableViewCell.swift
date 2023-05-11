//
//  TMsettingTableViewCell.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/3/30.
//

import Foundation
import UIKit

class TMsettingTableViewCell: UITableViewCell {
    lazy var titleView: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var infoView: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var navigationBar: UIImageView = {
        let image = UIImageView()
        return image
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor(named: "BackgroundGray")
        contentView.addSubview(titleView)
        contentView.addSubview(infoView)
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
        infoView.snp.makeConstraints { make in
            make.right.equalTo(navigationBar.snp.left).offset(-6)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(118)
        }
        navigationBar.image = UIImage(systemName: "chevron.forward")
        navigationBar.tintColor = UIColor(named: "ContentBackground")
        titleView.font = UIFont.systemFont(ofSize: 20)
        infoView.textAlignment = .right
    }

    func setupEvent(title: String, info: String) {
        titleView.text = title
        infoView.text = info
    }
}
