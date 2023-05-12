//
//  Commodity.swift
//  EDMS
//
//  Created by Jason Zhang on 2023/4/21.
//

import Foundation
import SwiftyJSON

struct Commodity: Codable, Equatable {
    var id: Int
    var images: [String]
    var name: String
    var intro: String
    var price: Double
    var limit: Int
    var orders: Int
    var cag: Int

    init(id: Int, images: [String], name: String, intro: String, price: Double, limit: Int, orders: Int, cag: Int) {
        self.id = id
        self.images = images
        self.name = name
        self.intro = intro
        self.price = price
        self.limit = limit
        self.orders = orders
        self.cag = cag
    }

    init(json: JSON) {
        id = json["id"].intValue
        images = json["images"].arrayValue.compactMap { $0.stringValue }
        name = json["name"].stringValue
        intro = json["intro"].stringValue
        price = json["price"].doubleValue
        limit = json["limit"].intValue
        orders = json["orders"].intValue
        cag = json["cag"].intValue
    }

    init() {
        self = Commodity(json: JSON())
    }

    func toDictionary() -> [String: Any] {
        let dict: [String: Any] = [
            "id": id,
            "images": images,
            "name": name,
            "intro": intro,
            "price": price,
            "limit": limit,
            "orders": orders,
            "cag": cag,
        ]
        return dict
    }

    init?(dict: [String: Any]) {
        guard let id = dict["id"] as? Int, let images = dict["images"] as? [String], let name = dict["name"] as? String, let intro = dict["intro"] as? String, let price = dict["price"] as? Double, let limit = dict["limit"] as? Int, let orders = dict["orders"] as? Int, let cag = dict["cag"] as? Int else {
            return nil
        }
        self = Commodity(id: id, images: images, name: name, intro: intro, price: price, limit: limit, orders: orders, cag: cag)
    }

    static func == (lhs: Commodity, rhs: Commodity) -> Bool {
        return lhs.id == rhs.id && lhs.images == rhs.images && lhs.name == rhs.name && lhs.intro == rhs.intro && lhs.price == rhs.price && lhs.limit == rhs.limit && lhs.orders == rhs.orders && lhs.cag == rhs.cag
    }
}
