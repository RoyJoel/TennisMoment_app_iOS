//
//  Option.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/6/6.
//

import Foundation
import SwiftyJSON

struct Option: Codable, Equatable {
    var id: Int
    var image: String
    var intro: String
    var price: Double
    var inventory: Int

    init(id: Int, image: String, intro: String, price: Double, inventory: Int) {
        self.id = id
        self.image = image
        self.intro = intro
        self.price = price
        self.inventory = inventory
    }

    init(json: JSON) {
        id = json["id"].intValue
        image = json["image"].stringValue
        intro = json["intro"].stringValue
        price = json["price"].doubleValue
        inventory = json["inventory"].intValue
    }

    init() {
        self = Option(json: JSON())
    }

    init?(dict: [String: Any]) {
        guard let id = dict["id"] as? Int,
            let image = dict["image"] as? String,
            let intro = dict["intro"] as? String, let price = dict["price"] as? Double, let inventory = dict["inventory"] as? Int
        else {
            return nil
        }

        self.init(id: id, image: image, intro: intro, price: price, inventory: inventory)
    }

    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "image": image,
            "intro": intro,
            "price": price,
            "inventory": inventory,
        ]
    }

    static func == (lhs: Option, rhs: Option) -> Bool {
        return lhs.id == rhs.id &&
            lhs.image == rhs.image &&
            lhs.intro == rhs.intro && lhs.price == rhs.price && lhs.inventory == rhs.inventory
    }
}

struct OptionRequest: Codable {
    var comId: Int
    var option: Option
}
