//
//  TMConfig.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2022/12/28.
//

import Foundation
import UIKit

/// TM基础视图，基于uiview扩展了缩放动画
open class TMView: UIView {
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

    public func addGroupAnimation(with views: [UIView], isEnlarge: Bool) {
        let widthRatio = newBounds.width / originalBounds.width
//        let heightRatio = self.newBounds.height / self.originalBounds.height
        let xDistance = newPoint.x - originalPoint.x
        let yDistance = newPoint.y - originalPoint.y

        if isEnlarge {
            for view in views {
                view.addAnimation(view.layer.position, CGPoint(x: view.layer.position.x + xDistance, y: view.layer.position.y + yDistance), duration, "position")
                view.addAnimation(view.bounds, CGRect(x: 0, y: 0, width: view.bounds.width * widthRatio, height: view.bounds.height * widthRatio), duration, "bounds")
//                print(view.layer.position)
//                print(xDistance,yDistance)
//                print(CGPoint(x: view.layer.position.x + xDistance, y: view.layer.position.y + yDistance))
            }
        } else {
            for view in views {
                view.addAnimation(CGPoint(x: view.layer.position.x + xDistance, y: view.layer.position.y + yDistance), view.layer.position, duration, "position")
                view.addAnimation(CGRect(x: 0, y: 0, width: view.bounds.width * widthRatio, height: view.bounds.height * widthRatio), view.bounds, duration, "bounds")
            }
        }
    }
}
