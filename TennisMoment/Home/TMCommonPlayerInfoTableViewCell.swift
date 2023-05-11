//
//  TMCommonPlayerInfoTableViewCell.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/4/11.
//

import Foundation
import UIKit
class TMCommonPlayerInfoTableViewCell: UITableViewCell {
    lazy var titleView: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var infoView: UILabel = {
        let label = UILabel()
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor(named: "ComponentBackground")
        contentView.addSubview(titleView)
        contentView.addSubview(infoView)
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
        infoView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-24)
            make.width.equalTo(188)
        }
        titleView.font = UIFont.systemFont(ofSize: 20)
        infoView.textAlignment = .right
    }

    func setupEvent(title: String, info: String) {
        titleView.text = title
        infoView.text = info
    }
}
