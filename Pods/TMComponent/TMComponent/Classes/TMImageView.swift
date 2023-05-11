//
//  TMImageView.swift
//  TMComponent
//
//  Created by Jason Zhang on 2023/3/24.
//

import Foundation
import UIKit

open class TMImageView: UIImageView {
    public func setup(config: TMImageViewConfig) {
        setupUI()
        setupEvent(config: config)
    }

    public func setupUI() {
        setCorner(radii: 15)
    }

    public func setupEvent(config: TMImageViewConfig) {
        image = UIImage(data: config.image)
        contentMode = config.contentMode
    }
}
