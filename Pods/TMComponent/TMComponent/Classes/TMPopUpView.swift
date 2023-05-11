//
//  TMPopUpView.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/3/15.
//

import Foundation
import UIKit

open class TMPopUpView: TMTableView, UITableViewDelegate {
    public var selectedIndex: IndexPath?
    public var selectedCompletionHandler: ((Int) -> Void)?

    public override func setupUI() {
        setCorner(radii: 8)
        super.setupUI()
        setupSize()
    }

    open func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        if toggle == false {
            deselectRow(at: IndexPath(row: 0, section: 0), animated: false)
            unfold()
        } else {
            selectedIndex = indexPath
            (selectedCompletionHandler ?? { _ in })(indexPath.row)
            setContentOffset(CGPoint(x: 0, y: 0), animated: false)
            UIView.performWithoutAnimation {
                moveRow(at: indexPath, to: IndexPath(row: 0, section: 0))
            }
            deselectRow(at: IndexPath(row: 0, section: 0), animated: false)
            fold()
        }
    }

    public func setupSize() {
        var scaledNum: CGFloat = 0
        var scaledHeight: CGFloat = 0
        if numberOfRows(inSection: 0) >= 4 {
            scaledNum = 4
            scaledHeight = layer.position.y + 1.5 * bounds.height
        } else {
            scaledNum = CGFloat(numberOfRows(inSection: 0))
            scaledHeight = layer.position.y + CGFloat(numberOfRows(inSection: 0) - 1) * 0.5 * bounds.height
        }
        setup(bounds, layer.position, CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height * scaledNum), CGPoint(x: layer.position.x, y: scaledHeight), 0.3)
    }

    public func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        originalBounds.height
    }

    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if !self.point(inside: point, with: nil), toggle == true {
            fold()
        }
        return super.hitTest(point, with: event)
    }
}
