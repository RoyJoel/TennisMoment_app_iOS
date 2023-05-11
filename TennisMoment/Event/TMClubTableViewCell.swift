//
//  TMClubTableViewCell.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/3/14.
//

import Foundation
import UIKit

class TMClubTableViewCell: UITableViewCell {
    lazy var clubIconView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    lazy var clubNameView: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var background: UIView = {
        let view = UIView()
        return view
    }()

    func setupUI() {
        backgroundColor = UIColor(named: "BackgroundGray")
        background.backgroundColor = UIColor(named: "ComponentBackground")
        background.setCorner(radii: 15)
        addSubview(background)
        background.addSubview(clubIconView)
        background.addSubview(clubNameView)
        clubIconView.setCorner(radii: 44)

        background.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
        }

        clubIconView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(22)
            make.centerY.equalToSuperview()
            make.width.equalTo(88)
            make.height.equalTo(88)
        }
        clubNameView.snp.makeConstraints { make in
            make.left.equalTo(clubIconView.snp.right).offset(12)
            make.top.equalTo(clubIconView.snp.top).offset(8)
            make.width.equalTo(200)
            make.height.equalTo(30)
        }
        clubIconView.contentMode = .scaleAspectFill
        clubNameView.font = UIFont.systemFont(ofSize: 22)
        clubNameView.textAlignment = .center
        clubNameView.textColor = UIColor(named: "ContentBackground")
    }

    func setupEvent(clubIcon: Data, clubName: String) {
        clubNameView.text = clubName
        clubIconView.image = UIImage(data: clubIcon)
    }
}
