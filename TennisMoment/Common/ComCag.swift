//
//  ComCag.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/6/6.
//

import Foundation

enum ComCag: Int, Codable, CaseIterable {
    case none = 0
    case Decoration = 1
    case ClothingMatching = 2
    case Accessories = 3
    case Tableware = 4
    case PictureFrame = 5

    var displayName: String {
        switch self {
        case .none:
            return "不限"
        case .Decoration:
            return "家居装饰"
        case .ClothingMatching:
            return "服饰搭配"
        case .Accessories:
            return "手机配件"
        case .Tableware:
            return "水杯餐具"
        case .PictureFrame:
            return "相框摆台"
        }
    }

    init(displayName: String) {
        switch displayName {
        case "家居装饰":
            self = .Decoration
        case "服饰搭配":
            self = .ClothingMatching
        case "手机配件":
            self = .Accessories
        case "水杯餐具":
            self = .Tableware
        case "相框摆台":
            self = .PictureFrame
        default:
            self = .none
        }
    }
}
