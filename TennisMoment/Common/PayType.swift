//
//  PayType.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/6/6.
//

import Foundation

enum payType: String, CaseIterable, Codable {
    case cashOnDelivery
    case aliPayOnline
    case weChatOnline

    var index: Int {
        switch self {
        case .cashOnDelivery:
            return 0
        case .aliPayOnline:
            return 1
        case .weChatOnline:
            return 2
        }
    }

    var displayName: String {
        switch self {
        case .cashOnDelivery:
            return "货到付款"
        case .weChatOnline:
            return "微信支付"
        case .aliPayOnline:
            return "支付宝"
        }
    }

    init(displayName: String) {
        switch displayName {
        case "支付宝":
            self = .aliPayOnline
        case "微信支付":
            self = .weChatOnline
        default:
            self = .cashOnDelivery
        }
    }
}
