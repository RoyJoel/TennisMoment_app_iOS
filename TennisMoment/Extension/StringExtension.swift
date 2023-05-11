//
//  StringExtionsion.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/3/6.
//

import Foundation

extension String {
    func convertToNum() -> Int {
        switch self {
        case "0":
            return 0
        case "15":
            return 1
        case "30":
            return 2
        case "40":
            return 3
        case "AD":
            return 4
        default:
            return 5
        }
    }

    func toPng() -> Data {
        let pngData = Data(base64Encoded: self)
        return pngData ?? Data()
    }
}
