//
//  TMInfoViewConfig.swift
//  TMComponent
//
//  Created by Jason Zhang on 2023/3/24.
//

import Foundation

open class TMInfoViewConfig {
    public var infoContent: String
    public var infoContentFont: CGFloat
    public var infoTitle: String
    public var infoTitleFont: CGFloat
    public var inset: Int

    public init(infoContent: String, infoContentFont: CGFloat, infoTitle: String, infoTitleFont: CGFloat, inset: Int) {
        self.infoContent = infoContent
        self.infoContentFont = infoContentFont
        self.infoTitle = infoTitle
        self.infoTitleFont = infoTitleFont
        self.inset = inset
    }
}
