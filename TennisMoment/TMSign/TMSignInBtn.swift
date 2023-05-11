//
//  TMLoginBtn.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/4/3.
//

import Foundation
import UIKit

class TMSignInBtn: UILabel {
    private var isBouncing = false

    var completion: (() -> Void)?

    func setupView() {
        backgroundColor = UIColor(named: "TennisBlur")
        setCorner(radii: bounds.height / 2)
        // 设置 label 的属性和文本
        font = UIFont.boldSystemFont(ofSize: 20)
        textColor = UIColor(named: "ContentBackground")
        textAlignment = .center
        text = NSLocalizedString("SignIn", comment: "")
        isUserInteractionEnabled = true
        // 添加点击手势
        addTapGesture(self, #selector(handleTapGesture))
    }

    func startBouncing() {
        guard !isBouncing else { return }
        isBouncing = true
        let bounceHeight = CGFloat(50)
        let bounceDuration: TimeInterval = 0.4
        let bounceDelay: TimeInterval = 0.1
        let options: UIView.AnimationOptions = [.curveEaseInOut, .autoreverse, .repeat]

        UIView.animate(withDuration: bounceDuration, delay: bounceDelay, options: options, animations: {
            self.transform = CGAffineTransform(translationX: 0, y: bounceHeight)
        }, completion: nil)
    }

    func stopBouncing() {
        guard isBouncing else { return }
        isBouncing = false
        UIView.animate(withDuration: 0.2, animations: {
            self.transform = CGAffineTransform.identity
        }, completion: { _ in
            self.layer.removeAllAnimations()
        })
    }

    @objc private func handleTapGesture() {
        // 执行弹跳动画
        startBouncing()
        completion?()
    }
}
