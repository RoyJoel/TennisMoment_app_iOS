//
//  UIViewExtension.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2022/12/26.
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

    func addLongPressGesture(_ target: Any, _ action: Selector?) {
        let longPress = UILongPressGestureRecognizer(target: target, action: action)
        addGestureRecognizer(longPress)
    }

    func addPanGesture(_ target: Any, _ action: Selector?) {
        let pan = UIPanGestureRecognizer(target: target, action: action)
        addGestureRecognizer(pan)
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

    func getParentViewController() -> UIViewController? {
        for view in sequence(first: superview, next: { view in
            view?.superview
        }) {
            if let responder = view?.next {
                if responder.isKind(of: UIViewController.self) {
                    return responder as? UIViewController
                }
            }
        }
        return nil
    }

//    func addAnimation(_ fromValue: Any?, _ ratio: CGFloat?, _ distance: CGFloat?, _ duration: CFTimeInterval, _ forKey: String?) {
//        let animation = CABasicAnimation()
//        animation.duration = duration
//        animation.fromValue = fromValue
//        if fromValue is CGPoint {
//            animation.toValue = CGPoint(x: ((fromValue as? CGPoint)?.x ?? 0) * times , y: ((fromValue as? CGPoint)?.y ?? 0) * times)
//        }
//        if fromValue is CGRect {
//            animation.toValue = CGRect(x: 0, y: 0, width: ((fromValue as? CGRect)?.width ?? 0) * times, height: ((fromValue as? CGRect)?.height ?? 0) * times)
//        }
//        animation.isRemovedOnCompletion = false
//        animation.fillMode = .forwards
//
//        layer.add(animation, forKey: forKey)
//    }
}
