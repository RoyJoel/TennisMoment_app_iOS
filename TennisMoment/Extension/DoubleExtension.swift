//
//  DoubleExtension.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/4/11.
//

import Foundation

extension Double {
    func TwoBitsRem() -> Int {
        Int(self * 10000) / 100
    }
}
