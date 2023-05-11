//
//  TMLabel.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/3/19.
//

import Foundation
import UIKit

open class TMLabel: UILabel {
    public var originalBounds: CGRect = .init()

    public var originalPoint: CGPoint = .init()

    public var newBounds: CGRect = .init()

    public var newPoint: CGPoint = .init()

    public var scaleTimes: CGFloat = .init()

    public var duration: CFTimeInterval = 0

    public var toggle: Bool = false

    public func setup(_ originalBounds: CGRect, _ originalPoint: CGPoint, _ newBounds: CGRect, _ newPoint: CGPoint, _ duration: CFTimeInterval) {
        self.originalBounds = originalBounds
        self.originalPoint = originalPoint
        self.newBounds = newBounds
        self.newPoint = newPoint
        self.duration = duration
    }

    open func scaleTo(_ isEnlarge: Bool) {
        if !isEnlarge {
            toggle.toggle()
            addAnimation(originalPoint, newPoint, duration, "position", completionHandler: {})
            addAnimation(originalBounds, newBounds, duration, "bounds", completionHandler: {})
            bounds = newBounds
            layer.position = newPoint
        } else {
            toggle.toggle()
            addAnimation(newBounds, originalBounds, duration, "bounds", completionHandler: {})
            addAnimation(newPoint, originalPoint, duration, "position", completionHandler: {})
            bounds = originalBounds
            layer.position = originalPoint
        }
    }

    open func scaleTo(_ isEnlarge: Bool, completionHandler: @escaping () -> Void) {
        if !isEnlarge {
            toggle.toggle()
            addAnimation(originalPoint, newPoint, duration, "position", completionHandler: {})
            addAnimation(originalBounds, newBounds, duration, "bounds", completionHandler: {
                completionHandler()
            })
            bounds = newBounds
            layer.position = newPoint
        } else {
            toggle.toggle()
            addAnimation(newBounds, originalBounds, duration, "bounds", completionHandler: {})
            addAnimation(newPoint, originalPoint, duration, "position", completionHandler: {
                completionHandler()
            })
            bounds = originalBounds
            layer.position = originalPoint
        }
    }

    public func setupEvent(config: TMLabelConfig) {
        text = config.title
        font = UIFont.systemFont(ofSize: config.font)
    }
}
