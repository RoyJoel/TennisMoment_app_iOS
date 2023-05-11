//
//  TMButton.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/2/17.
//

import Foundation
import UIKit

open class TMButton: UIButton {
    public var config = TMButtonConfig(title: "", action: #selector(method), actionTarget: TMButton.self)

    public func setUp(with config: TMButtonConfig) {
        setupUI()
        setupEvent(config: config)
    }

    public func setupUI() {
        setTitleColor(UIColor(named: "ContentBackground"), for: .normal)
        setTitleColor(UIColor(named: "TennisBlur"), for: .selected)
        backgroundColor = UIColor(named: "ComponentBackground")
        titleLabel?.numberOfLines = 2
        titleLabel?.textAlignment = .center
        setCorner(radii: 15)
    }

    public func setupEvent(config: TMButtonConfig) {
        self.config = config
        setTitle(config.title, for: .normal)
        addTapGesture(config.actionTarget, config.action)
    }
}
