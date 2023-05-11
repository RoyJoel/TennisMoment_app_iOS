//
//  TMPopUpViewCell.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/3/15.
//

import Foundation
import UIKit

open class TMPopUpCell: UITableViewCell {
    lazy var label: UILabel = {
        let label = UILabel()
        return label
    }()

    public func setupUI() {
        addSubview(label)
        label.backgroundColor = UIColor(named: "BackgroundGray")
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        label.textAlignment = .center
    }

    public func setupEvent(title: String) {
        label.text = title
    }
}
