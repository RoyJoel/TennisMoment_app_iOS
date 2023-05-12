//
//  Order.swift
//  EDMS
//
//  Created by Jason Zhang on 2023/4/24.
//

import Foundation
import SwiftyJSON

struct Order: Codable, Equatable {
    var id: Int
    var bills: [Bill]
    var shippingAddress: Address
    var deliveryAddress: Address
    var payment: Payment
    var totalPrice: Double
    var createdTime: TimeInterval
    var payedTime: TimeInterval?
    var completedTime: TimeInterval?
    var state: OrderState

    init(id: Int, bills: [Bill], shippingAddress: Address, deliveryAddress: Address, payment: Payment, totalPrice: Double, createdTime: TimeInterval, payedTime: TimeInterval? = nil, completedTime: TimeInterval? = nil, state: OrderState) {
        self.id = id
        self.bills = bills
        self.shippingAddress = shippingAddress
        self.deliveryAddress = deliveryAddress
        self.payment = payment
        self.totalPrice = totalPrice
        self.createdTime = createdTime
        self.payedTime = payedTime
        self.completedTime = completedTime
        self.state = state
    }

    init(json: JSON) {
        id = json["id"].intValue
        bills = json["bills"].arrayValue.map { Bill(json: $0) }
        shippingAddress = Address(json: json["shippingAddress"])
        deliveryAddress = Address(json: json["deliveryAddress"])
        payment = Payment(rawValue: json["payment"].stringValue) ?? .WeChat
        totalPrice = json["totalPrice"].doubleValue
        createdTime = json["createdTime"].doubleValue
        payedTime = json["payedTime"].doubleValue
        completedTime = json["completedTime"].doubleValue
        state = OrderState(rawValue: json["state"].intValue) ?? .ToPay
    }

    init() {
        self = Order(json: JSON())
    }

    init?(dictionary: [String: Any]) {
        guard let id = dictionary["id"] as? Int,
            let billsArray = dictionary["bills"] as? [[String: Any]],
            let shippingAddressDict = dictionary["shippingAddress"] as? [String: Any],
            let deliveryAddressDict = dictionary["deliveryAddress"] as? [String: Any], let payment = dictionary["payment"] as? String, let state = dictionary["state"] as? Int, let totalPrice = dictionary["totalPrice"] as? Double,
            let createdTime = dictionary["createdTime"] as? TimeInterval else {
            return nil
        }

        self.id = id
        bills = billsArray.compactMap { Bill(dictionary: $0) }
        shippingAddress = Address(dictionary: shippingAddressDict)!
        deliveryAddress = Address(dictionary: deliveryAddressDict)!
        self.state = OrderState(rawValue: state) ?? .ToPay
        self.payment = Payment(rawValue: payment) ?? .WeChat
        self.totalPrice = totalPrice
        self.createdTime = createdTime

        if let payedTime = dictionary["payedTime"] as? TimeInterval {
            self.payedTime = payedTime
        }

        if let completedTime = dictionary["completedTime"] as? TimeInterval {
            self.completedTime = completedTime
        }
    }

    func toDictionary() -> [String: Any] {
        var dict: [String: Any] = [
            "id": id,
            "bills": bills.map { $0.toDictionary() },
            "shippingAddress": shippingAddress.toDictionary(),
            "deliveryAddress": deliveryAddress.toDictionary(),
            "totalPrice": totalPrice,
            "payment": payment.rawValue,
            "state": state.rawValue,
            "createdTime": createdTime,
        ]

        if let payedTime = payedTime {
            dict["payedTime"] = payedTime
        }

        if let completedTime = completedTime {
            dict["completedTime"] = completedTime
        }

        return dict
    }

    static func == (lhs: Order, rhs: Order) -> Bool {
        return lhs.id == rhs.id &&
            lhs.bills == rhs.bills &&
            lhs.shippingAddress == rhs.shippingAddress &&
            lhs.deliveryAddress == rhs.deliveryAddress && lhs.payment == rhs.payment && lhs.totalPrice == rhs.totalPrice &&
            lhs.createdTime == rhs.createdTime && lhs.state == rhs.state &&
            lhs.payedTime == rhs.payedTime &&
            lhs.completedTime == rhs.completedTime
    }
}

enum OrderState: Int, CaseIterable, Codable {
    case ToPay = 0
    case ToSend = 1
    case ToDelivery = 2
    case Done = 3
    case ToRefund = 4
    case ToReturn = 5
    case Refunded = 6

    var displayName: String {
        switch self {
        case .ToPay: return "待支付"
        case .ToSend: return "待发货"
        case .ToDelivery: return "待签收"
        case .Done: return "已完成"
        case .ToRefund: return "需退货"
        case .ToReturn: return "需退款"
        case .Refunded: return "已退款"
        }
    }
}
