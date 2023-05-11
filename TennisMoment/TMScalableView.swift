//
//  recordView.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/2/11.
//

import Foundation
import TMComponent
import UIKit

class TMScalableView: TMView {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        let tmview = view as? TMScalableView

        if let tmview = tmview {
            if tmview.toggle == false {
                return tmview
            } else {
                if tmview == self {
                    return nil
                }
                return view
            }
        }
        return super.hitTest(point, with: event)
    }
}
