//
//  TMImageView.swift
//  TMComponent
//
//  Created by Jason Zhang on 2023/3/24.
//

import Foundation
import UIKit

open class TMImageViewConfig {
    public var image: Data
    public var contentMode: UIView.ContentMode
    public init(image: Data, contentMode: UIView.ContentMode) {
        self.image = image
        self.contentMode = contentMode
    }
}
