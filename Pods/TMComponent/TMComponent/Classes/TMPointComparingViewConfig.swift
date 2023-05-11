//
//  TMVSViewConfig.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/2/17.
//

import Foundation
import UIKit

open class TMPointComparingViewConfig {
    public var isTitleViewAbovePointView: Bool
    public var isTitleHidden: Bool
    public var title: String?
    public var iconName: String?
    public var isServingOnLeft: Bool
    public var areBothServing: Bool
    public var isComparing: Bool
    public var font: UIFont
    public var leftNum: String
    public var rightNum: String

    public init(isTitleViewAbovePointView: Bool, isTitleHidden: Bool, title: String? = nil, iconName: String? = nil, isServingOnLeft: Bool, areBothServing: Bool, isComparing: Bool, font: UIFont, leftNum: String, rightNum: String) {
        self.isTitleViewAbovePointView = isTitleViewAbovePointView
        self.isTitleHidden = isTitleHidden
        self.title = title
        self.iconName = iconName
        self.isServingOnLeft = isServingOnLeft
        self.areBothServing = areBothServing
        self.isComparing = isComparing
        self.font = font
        self.leftNum = leftNum
        self.rightNum = rightNum
    }
}
