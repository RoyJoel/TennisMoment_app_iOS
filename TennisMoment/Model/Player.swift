//
//  Player.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/2/25.
//

import Foundation
import SwiftyJSON

struct Player: Codable, Equatable {
    var id: Int
    var loginName: String
    var name: String
    var icon: String
    var sex: Sex
    var age: Int
    var yearsPlayed: Int
    var height: Float
    var width: Float
    var grip: Grip
    var backhand: Backhand
    var points: Int
    var isAdult: Bool
    var careerStats: Stats

    init(id: Int, loginName: String, name: String, icon: String, sex: Sex, age: Int, yearsPlayed: Int, height: Float, width: Float, grip: Grip, backhand: Backhand, points: Int, isAdult: Bool, careerStats: Stats) {
        self.id = id
        self.loginName = loginName
        self.name = name
        self.icon = icon
        self.sex = sex
        self.age = age
        self.yearsPlayed = yearsPlayed
        self.height = height
        self.width = width
        self.grip = grip
        self.backhand = backhand
        self.points = points
        self.isAdult = isAdult
        self.careerStats = careerStats
    }

    init(json: JSON) {
        id = json["id"].intValue
        loginName = json["loginName"].stringValue
        name = json["name"].stringValue
        icon = json["icon"].stringValue
        sex = Sex(rawValue: json["sex"].stringValue) ?? .Man
        age = json["age"].intValue
        yearsPlayed = json["yearsPlayed"].intValue
        height = json["height"].floatValue
        width = json["width"].floatValue
        grip = Grip(rawValue: json["grip"].stringValue) ?? .Continented
        backhand = Backhand(rawValue: json["backhand"].stringValue) ?? .TwoHandedBackhand
        points = json["points"].intValue
        isAdult = json["isAdult"].boolValue
        careerStats = Stats(json: json["careerStats"])
    }

    init?(dictionary: [String: Any]) {
        guard let id = dictionary["id"] as? Int,
            let loginName = dictionary["loginName"] as? String,
            let name = dictionary["name"] as? String,
            let icon = dictionary["icon"] as? String,
            let sexRawValue = dictionary["sex"] as? String,
            let sex = Sex(rawValue: sexRawValue),
            let age = dictionary["age"] as? Int,
            let yearsPlayed = dictionary["yearsPlayed"] as? Int,
            let height = dictionary["height"] as? Float,
            let width = dictionary["width"] as? Float,
            let gripRawValue = dictionary["grip"] as? String,
            let grip = Grip(rawValue: gripRawValue),
            let backhandRawValue = dictionary["backhand"] as? String,
            let backhand = Backhand(rawValue: backhandRawValue),
            let points = dictionary["points"] as? Int,
            let isAdult = dictionary["isAdult"] as? Bool,
            let statsDictionary = dictionary["careerStats"] as? [String: Any],
            let careerStats = Stats(dict: statsDictionary) else {
            return nil
        }

        self.init(id: id, loginName: loginName, name: name, icon: icon, sex: sex, age: age, yearsPlayed: yearsPlayed, height: height, width: width, grip: grip, backhand: backhand, points: points, isAdult: isAdult, careerStats: careerStats)
    }

    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "loginName": loginName,
            "name": name,
            "icon": icon,
            "sex": sex.rawValue,
            "age": age,
            "yearsPlayed": yearsPlayed,
            "height": height,
            "width": width,
            "grip": grip.rawValue,
            "backhand": backhand.rawValue,
            "points": points,
            "isAdult": isAdult,
            "careerStats": careerStats.toDictionary(),
        ]
    }

    init() {
        self = Player(json: JSON())
    }

    static func == (lhs: Player, rhs: Player) -> Bool {
        return lhs.id == rhs.id &&
            lhs.loginName == rhs.loginName &&
            lhs.name == rhs.name &&
            lhs.icon == rhs.icon &&
            lhs.sex == rhs.sex &&
            lhs.age == rhs.age &&
            lhs.yearsPlayed == rhs.yearsPlayed &&
            Int(lhs.height * 100) == Int(rhs.height * 100) &&
            Int(lhs.width * 100) == Int(rhs.width * 100) &&
            lhs.grip == rhs.grip &&
            lhs.backhand == rhs.backhand &&
            lhs.points == rhs.points &&
            lhs.isAdult == rhs.isAdult &&
            lhs.careerStats == rhs.careerStats
    }
}

enum Sex: String, Codable, CaseIterable {
    case Man
    case Woman
}

enum Grip: String, Codable {
    case Continented
    case Eastern
    case SemiWestern
    case Western

    var index: String {
        switch self {
        case .Continented: return "0"
        case .Eastern: return "1"
        case .SemiWestern: return "2"
        case .Western: return "3"
        }
    }
}

enum Backhand: String, Codable {
    case OneHanded = "One-Handed"
    case TwoHandedBackhand = "Two-Handed"

    var index: String {
        switch self {
        case .OneHanded: return "0"
        case .TwoHandedBackhand: return "1"
        }
    }
}
