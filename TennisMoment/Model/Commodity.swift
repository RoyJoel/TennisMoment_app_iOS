//
//  Commodity.swift
// TennisMoment
//
//  Created by Jason Zhang on 2023/4/21.
//

import Foundation
import SwiftyJSON

struct Commodity: Codable, Equatable {
    var id: Int
    var name: String
    var intro: String
    var orders: Int
    var options: [Option]
    var cag: ComCag
    var state: CommodityState

    init(id: Int, options: [Option], name: String, intro: String, orders: Int, cag: ComCag, state: CommodityState) {
        self.id = id
        self.options = options
        self.name = name
        self.intro = intro
        self.orders = orders
        self.cag = cag
        self.state = state
    }

    init(json: JSON) {
        id = json["id"].intValue
        options = json["options"].arrayValue.compactMap { Option(json: $0) }
        name = json["name"].stringValue
        intro = json["intro"].stringValue
        orders = json["orders"].intValue
        cag = ComCag(rawValue: json["cag"].intValue) ?? .Accessories
        state = CommodityState(rawValue: json["state"].intValue) ?? .ToArrived
    }

    init() {
        self = Commodity(json: JSON())
    }

    func toDictionary() -> [String: Any] {
        let dict: [String: Any] = [
            "id": id,
            "options": options,
            "name": name,
            "intro": intro,
            "orders": orders,
            "cag": cag,
            "state": state.rawValue,
        ]
        return dict
    }

    init?(dict: [String: Any]) {
        guard let id = dict["id"] as? Int, let optiondits = dict["options"] as? [[String: Any]], let name = dict["name"] as? String, let intro = dict["intro"] as? String, let orders = dict["orders"] as? Int, let cag = dict["cag"] as? Int, let stateRawValue = dict["state"] as? Int else {
            return nil
        }

        let options = optiondits.map { Option(dict: $0) ?? Option() }
        let comcag = ComCag(rawValue: cag) ?? .Accessories
        let state = CommodityState(rawValue: stateRawValue) ?? .ToArrived
        self = Commodity(id: id, options: options, name: name, intro: intro, orders: orders, cag: comcag, state: state)
    }

    static func == (lhs: Commodity, rhs: Commodity) -> Bool {
        return lhs.id == rhs.id && lhs.options == rhs.options && lhs.name == rhs.name && lhs.intro == rhs.intro && lhs.orders == rhs.orders && lhs.cag == rhs.cag && lhs.state == rhs.state
    }
}
