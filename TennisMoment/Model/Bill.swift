//
//  Bill.swift
// TennisMoment
//
//  Created by Jason Zhang on 2023/4/24.
//

import Foundation
import SwiftyJSON

struct Bill: Codable, Equatable {
    var id: Int
    var com: Commodity
    var quantity: Int
    var option: Option

    init(id: Int, com: Commodity, quantity: Int, option: Option) {
        self.id = id
        self.com = com
        self.quantity = quantity
        self.option = option
    }

    init(json: JSON) {
        id = json["id"].intValue
        com = Commodity(json: json["com"])
        quantity = json["quantity"].intValue
        option = Option(json: json["option"])
    }

    init?(dictionary: [String: Any]) {
        guard let id = dictionary["id"] as? Int,
            let comDict = dictionary["comId"] as? [String: Any], let com = Commodity(dict: comDict),
            let quantity = dictionary["quantity"] as? Int,
            let optionDict = dictionary["opinion"] as? [String: Any] else {
            return nil
        }

        let option = Option(dict: optionDict) ?? Option()

        self.init(id: id, com: com, quantity: quantity, option: option)
    }

    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "com": com.toDictionary(),
            "quantity": quantity,
            "option": option,
        ]
    }

    init() {
        self = Bill(json: JSON())
    }

    static func == (lhs: Bill, rhs: Bill) -> Bool {
        return lhs.id == rhs.id &&
            lhs.com == rhs.com &&
            lhs.quantity == rhs.quantity &&
            lhs.option == rhs.option
    }
}

struct BillRequest: Codable, Equatable {
    var id: Int
    var comId: Int
    var quantity: Int
    var optionId: Int
    var orderId: Int

    init(id: Int, comId: Int, quantity: Int, optionId: Int, orderId: Int) {
        self.id = id
        self.comId = comId
        self.quantity = quantity
        self.optionId = optionId
        self.orderId = orderId
    }

    init(json: JSON) {
        id = json["id"].intValue
        comId = json["comId"].intValue
        quantity = json["quantity"].intValue
        optionId = json["optionId"].intValue
        orderId = json["orderId"].intValue
    }
}
