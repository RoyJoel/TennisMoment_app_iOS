//
//  CLub.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/3/14.
//

import Foundation
import SwiftyJSON

struct Club: Codable, Equatable {
    var id: Int
    var icon: String
    var name: String
    var intro: String
    var owner: Player
    var address: String
    var events: [Event]

    init(id: Int, icon: String, name: String, intro: String, owner: Player, address: String, events: [Event]) {
        self.id = id
        self.icon = icon
        self.name = name
        self.intro = intro
        self.owner = owner
        self.address = address
        self.events = events
    }

    init(json: JSON) {
        id = json["id"].intValue
        icon = json["icon"].stringValue
        name = json["name"].stringValue
        intro = json["intro"].stringValue
        owner = Player(json: json["owner"])
        address = json["address"].stringValue
        events = json["events"].arrayValue.map { Event(json: $0) }
    }

    init() {
        self = Club(json: JSON())
    }

    init?(dict: [String: Any]) {
        guard let id = dict["id"] as? Int,
            let icon = dict["icon"] as? String,
            let name = dict["name"] as? String,
            let intro = dict["intro"] as? String,
            let ownerDict = dict["owner"] as? [String: Any],
            let owner = Player(dictionary: ownerDict),
            let address = dict["address"] as? String,
            let eventsDict = dict["events"] as? [[String: Any]]
        else {
            return nil
        }

        var events = [Event]()
        for eventDict in eventsDict {
            if let event = Event(dict: eventDict) {
                events.append(event)
            }
        }

        self.init(id: id, icon: icon, name: name, intro: intro, owner: owner, address: address, events: events)
    }

    func toDictionary() -> [String: Any] {
        var dict = [String: Any]()
        dict["id"] = id
        dict["icon"] = icon
        dict["name"] = name
        dict["intro"] = intro
        dict["owner"] = owner.toDictionary()
        dict["address"] = address

        var eventsDict = [[String: Any]]()
        for event in events {
            eventsDict.append(event.toDictionary())
        }
        dict["events"] = eventsDict

        return dict
    }

    static func == (lhs: Club, rhs: Club) -> Bool {
        return lhs.id == rhs.id &&
            lhs.icon == rhs.icon &&
            lhs.name == rhs.name &&
            lhs.intro == rhs.intro &&
            lhs.owner == rhs.owner &&
            lhs.address == rhs.address &&
            lhs.events == rhs.events
    }
}
