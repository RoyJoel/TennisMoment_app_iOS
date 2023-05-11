//
//  TMProgressView.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/4/5.
//

import Foundation
import UIKit

class TMProgressView: UIView {
    // 进度条曲线
    private let progressLayer = CAShapeLayer()

    // 进度值（0.0 ~ 1.0）
    var progress: CGFloat = 0 {
        didSet {
            // 生成新的曲线路径
            let newPath = generatePath().cgPath
            // 创建路径动画
            let pathAnimation = CABasicAnimation(keyPath: "path")
            pathAnimation.duration = 0.3
            pathAnimation.fromValue = progressLayer.path
            pathAnimation.toValue = newPath
            // 设置动画结束后保持最终状态
            pathAnimation.fillMode = .forwards
            pathAnimation.isRemovedOnCompletion = false
            // 添加动画
            progressLayer.add(pathAnimation, forKey: "pathAnimation")
            progressLayer.path = newPath
        }
    }

    func setupUI() {
        backgroundColor = UIColor.lightGray
        layer.cornerRadius = 8
        layer.borderWidth = 2
        layer.borderColor = UIColor.darkGray.cgColor
        // 添加进度条曲线
        layer.addSublayer(progressLayer)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        // 重新布局进度条曲线
        progressLayer.frame = bounds
        progressLayer.path = generatePath().cgPath
    }

    // 生成进度条曲线
    private func generatePath() -> UIBezierPath {
        let path = UIBezierPath()
        let height = bounds.midY
        let width = bounds.width

        // 计算进度值对应的宽度
        let progressWidth = width * progress
        // 根据进度值计算曲线上的点
        let controlPoint = CGPoint(x: 0, y: height)

        // 绘制曲线
        path.lineWidth = 50
        path.move(to: controlPoint)
        path.addQuadCurve(to: CGPoint(x: progressWidth, y: height),
                          controlPoint: controlPoint)
        path.addLine(to: CGPoint(x: width, y: height))
        return path
    }
}
