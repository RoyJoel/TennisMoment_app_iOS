//
//  TMSettingSelectionCell.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/3/31.
//

import Foundation
import UIKit

class TMSettingSelectionCell: UITableViewCell {
    override var isSelected: Bool {
        didSet {
            isBeenSelected = isSelected
        }
    }

    @objc dynamic var isBeenSelected: Bool = false
    lazy var titleView: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var selectionView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor(named: "BackgroundGray")
        contentView.addSubview(titleView)
        contentView.addSubview(selectionView)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        titleView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.top.equalToSuperview().offset(45)
            make.bottom.equalToSuperview().offset(-45)
            make.width.equalToSuperview().offset(200)
        }
        selectionView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-12)
            make.top.equalToSuperview().offset(45)
            make.bottom.equalToSuperview().offset(-45)
            make.width.equalTo(28)
        }
    }

    override func observeValue(forKeyPath keyPath: String?, of _: Any?, change: [NSKeyValueChangeKey: Any]?, context _: UnsafeMutableRawPointer?) {
        if keyPath == "isBeenSelected" {
            if let newValue = change?[.newKey] as? Bool {
                if newValue == true {
                    selectionView.image = UIImage(systemName: "checkmark.circle.fill")
                    selectionView.tintColor = UIColor(named: "ContentBackground")
                } else {
                    selectionView.image = UIImage(systemName: "checkmark.circle")
                    selectionView.tintColor = UIColor(named: "ContentBackground")
                }
            }
        }
    }

    func setupEvent(title: String) {
        titleView.text = title
    }
}
