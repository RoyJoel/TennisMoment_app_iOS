//
//  UIStandard.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2022/12/27.
//

import Foundation
import UIKit

class UIStandard {
    static let shared = UIStandard()
    private init() {}
    var screenWidth = UIScreen.main.bounds.width
    var screenHeight = UIScreen.main.bounds.height
}
