//
//  TMTextFieldConfig.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/3/2.
//

import Foundation

open class TMTextFieldConfig {
    public var placeholderText: String
    public var text: String?
    init(placeholderText: String, text: String? = nil) {
        self.placeholderText = placeholderText
        self.text = text
    }
}
