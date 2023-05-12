//
//  Bill.swift
//  EDMS
//
//  Created by Jason Zhang on 2023/4/24.
//

import Foundation
import SwiftyJSON

struct Bill: Codable, Equatable {
    var id: Int
    var com: Commodity
    var quantity: Int
    var cag: Int

    init(id: Int, com: Commodity, quantity: Int, cag: Int) {
        self.id = id
        self.com = com
        self.quantity = quantity
        self.cag = cag
    }

    init(json: JSON) {
        id = json["id"].intValue
        com = Commodity(json: json["com"])
        quantity = json["quantity"].intValue
        cag = json["cag"].intValue
    }

    init?(dictionary: [String: Any]) {
        guard let id = dictionary["id"] as? Int,
            let comDict = dictionary["comId"] as? [String: Any], let com = Commodity(dict: comDict),
            let quantity = dictionary["quantity"] as? Int,
            let cag = dictionary["cag"] as? Int else {
            return nil
        }

        self.init(id: id, com: com, quantity: quantity, cag: cag)
    }

    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "com": com.toDictionary(),
            "quantity": quantity,
            "cag": cag,
        ]
    }

    init() {
        self = Bill(json: JSON())
    }

    static func == (lhs: Bill, rhs: Bill) -> Bool {
        return lhs.id == rhs.id &&
            lhs.com == rhs.com &&
            lhs.quantity == rhs.quantity &&
            lhs.cag == rhs.cag
    }
}

enum Payment: String, Codable, CaseIterable {
    case WeChat
    case AliPay
}
