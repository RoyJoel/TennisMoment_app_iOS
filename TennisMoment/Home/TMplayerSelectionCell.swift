//
//  TMplayerSelectionCell.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/3/16.
//

import Foundation
import UIKit

class TMplayerSelectionCell: UITableViewCell {
    var playerId = 0
    lazy var playerIconView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    lazy var playerNameView: UILabel = {
        let label = UILabel()
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(playerIconView)
        addSubview(playerNameView)
        backgroundColor = UIColor(named: "BackgroundGray")
        layoutSubviews()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        playerIconView.setCorner(radii: 5)
        playerIconView.contentMode = .scaleAspectFill

        playerIconView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.height.equalTo(32)
            make.left.equalToSuperview().offset(12)
        }
        playerNameView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(playerIconView.snp.right).offset(6)
        }
    }

    func setupEvent(imageName: Data, playerName: String, playerId: Int) {
        self.playerId = playerId
        playerIconView.image = UIImage(data: imageName)
        playerNameView.text = playerName
    }
}
