//
//  IntExtension.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/3/6.
//

import Foundation

extension Int {
    func convertToPoint() -> String {
        switch self {
        case 0:
            return "0"
        case 1:
            return "15"
        case 2:
            return "30"
        case 3:
            return "40"
        case 4:
            return "AD"
        default:
            return "GAME"
        }
    }
}
