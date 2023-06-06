//
//  CommodityState.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/6/6.
//

import Foundation

enum CommodityState: Int, CaseIterable, Codable {
    case ToArrived = 0
    case selling = 1
    case Banned = 2

    var displayName: String {
        switch self {
        case .ToArrived: return "待上架"
        case .selling: return "出售中"
        case .Banned: return "已下架"
        }
    }
}
