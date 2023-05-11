//
//  TMLabelConfig.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/2/17.
//

import Foundation
import UIKit

open class TMmultiplyConfigurableViewConfig {
    public var rowHeight: CGFloat
    public var rowSpacing: CGFloat
    public var configs: [TMPointComparingViewConfig]

    public init(rowHeight: CGFloat, rowSpacing: CGFloat, configs: [TMPointComparingViewConfig]) {
        self.rowHeight = rowHeight
        self.rowSpacing = rowSpacing
        self.configs = configs
    }

//    static func defaultConfig() -> TMComponentConfig {
//        return TMPointRecordViewConfig(setViewConfig: TMVSViewConfig(isTitleViewAbovePointView: true, title: "SET", leftConfig: TMBasicPointViewConfig(isLeft: true, font: UIFont(), num: 0), rightConfig: TMBasicPointViewConfig(isLeft: false, font: UIFont(), num: 0)), gameViewConfig: TMVSViewConfig(isTitleViewAbovePointView: true, title: "GAME", leftConfig: TMBasicPointViewConfig(isLeft: true, font: UIFont(), num: 0), rightConfig: TMBasicPointViewConfig(isLeft: false, font: UIFont(), num: 0)), pointViewConfig: TMVSViewConfig(isTitleViewAbovePointView: true, title: "POINT", leftConfig: TMBasicPointViewConfig(isLeft: true, font: UIFont(), num: 0), rightConfig: TMBasicPointViewConfig(isLeft: false, font: UIFont(), num: 0)))
//    }
}
