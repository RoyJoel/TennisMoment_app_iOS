//
//  UIViewExtension.swift
//  TMComponents
//
//  Created by Jason Zhang on 2023/2/21.
//

import Foundation
import UIKit

extension UIView {
    func setShadow(_ shadowRadius: CGFloat, _ shadowOffset: CGSize, _ shadowColor: CGColor = UIColor.black.cgColor, _ shadowOpacity: Float = 0.5) {
        layer.shadowRadius = shadowRadius
        layer.shadowOffset = shadowOffset
        layer.shadowColor = shadowColor
        layer.shadowOpacity = shadowOpacity
    }

    func setCorner(radii: CGFloat, masksToBounds: Bool = true) {
        layer.cornerRadius = radii
        layer.masksToBounds = masksToBounds
    }

    func drawBorder(color: UIColor, width: CGFloat) {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
    }

    func addTapGesture(_ target: Any, _ action: Selector?) {
        let tap = UITapGestureRecognizer(target: target, action: action)
        addGestureRecognizer(tap)
    }

    func removeTapGesture(_ target: Any, _ action: Selector?) {
        let tap = UITapGestureRecognizer(target: target, action: action)
        removeGestureRecognizer(tap)
    }

    func addAnimation(_ fromValue: Any?, _ toValue: Any?, _ duration: CFTimeInterval, _ forKey: String?) {
        let animation = CABasicAnimation()
        animation.duration = duration
        animation.fromValue = fromValue
        animation.toValue = toValue
        animation.fillMode = .forwards

        layer.add(animation, forKey: forKey)
    }

    func addAnimation(_ fromValue: Any?, _ toValue: Any?, _ duration: CFTimeInterval, _ forKey: String?, completionHandler: @escaping () -> Void) {
        let animation = CABasicAnimation()
        animation.duration = duration
        animation.fromValue = fromValue
        animation.toValue = toValue
        animation.fillMode = .forwards

        CATransaction.begin()
        CATransaction.setCompletionBlock {
            completionHandler()
        }
        layer.add(animation, forKey: forKey)
        CATransaction.commit()
    }
}
