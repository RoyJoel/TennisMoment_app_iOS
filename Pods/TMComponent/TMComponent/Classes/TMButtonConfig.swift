//
//  TMButtonConfig.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/2/17.
//

import Foundation

open class TMButtonConfig {
    public var title: String
    public var action: Selector?
    public var actionTarget: Any

    public init(title: String, action: Selector? = nil, actionTarget: Any) {
        self.title = title
        self.action = action
        self.actionTarget = actionTarget
    }
}
