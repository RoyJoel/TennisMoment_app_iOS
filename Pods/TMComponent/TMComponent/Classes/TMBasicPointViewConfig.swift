//
//  TMBasicPointConfig.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/2/17.
//

import Foundation
import UIKit

open class TMBasicPointViewConfig {
    public var isLeft: Bool
    public var iconName: String?
    public var isServing: Bool
    public var num: String
    public var font: UIFont

    public init(isLeft: Bool, iconName: String? = nil, isServing: Bool, num: String, font: UIFont) {
        self.isLeft = isLeft
        self.iconName = iconName
        self.isServing = isServing
        self.num = num
        self.font = font
    }
}
