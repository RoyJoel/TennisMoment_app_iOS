//
//  EDCagSelectionCell.swift
//  EDMS
//
//  Created by Jason Zhang on 2023/4/22.
//

import Foundation
import UIKit

class TMCagSelectionCell: UICollectionViewCell {
    override var isSelected: Bool {
        didSet {
            isBeenSelected = isSelected
        }
    }

    @objc dynamic var isBeenSelected: Bool = false

    lazy var comIconView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    func setupUI() {
        backgroundColor = UIColor(named: "ComponentBackground")
        setCorner(radii: 15)
        contentView.addSubview(comIconView)

        comIconView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalToSuperview()
        }

        comIconView.contentMode = .scaleAspectFill
    }

    override func observeValue(forKeyPath keyPath: String?, of _: Any?, change: [NSKeyValueChangeKey: Any]?, context _: UnsafeMutableRawPointer?) {
        if keyPath == "isBeenSelected" {
            if let newValue = change?[.newKey] as? Bool {
                if newValue == true {
                    drawBorder(color: UIColor(named: "TennisBlur") ?? .green, width: 5)
                } else {
                    removeBorder()
                }
            }
        }
    }

    func setupEvent(icon: String) {
        let icon = UIImage(named: icon)
        comIconView.image = icon
    }
}
