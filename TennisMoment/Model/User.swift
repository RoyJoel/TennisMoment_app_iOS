//
//  User.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/3/19.
//

import Foundation
import SwiftyJSON

struct User: Codable, Equatable {
    var id: Int
    var loginName: String
    var password: String
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
    var friends: [Player]
    var allClubs: [Int]
    var allHistoryGames: [Game]
    var allUnfinishedGames: [Game]
    var allEvents: [Int]
    var allSchedules: [Schedule]
    var addresss: [Int]
    var allOrders: [Int]
    var cart: Int
    var defaultAddress: Address
    var token: String

    init(id: Int, loginName: String, password: String, name: String, icon: String, sex: Sex, age: Int, yearsPlayed: Int, height: Float, width: Float, grip: Grip, backhand: Backhand, points: Int, isAdult: Bool, careerStats: Stats, friends: [Player], allClubs: [Int], allHistoryGames: [Game], allUnfinishedGames: [Game], allEvents: [Int], allSchedules: [Schedule], addresss: [Int], allOrders: [Int], cart: Int, defaultAddress: Address, token: String) {
        self.id = id
        self.loginName = loginName
        self.password = password
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
        self.friends = friends
        self.allClubs = allClubs
        self.allHistoryGames = allHistoryGames
        self.allUnfinishedGames = allUnfinishedGames
        self.allEvents = allEvents
        self.allSchedules = allSchedules
        self.addresss = addresss
        self.allOrders = allOrders
        self.cart = cart
        self.defaultAddress = defaultAddress
        self.token = token
    }

    init(json: JSON) {
        id = json["id"].intValue
        loginName = json["loginName"].stringValue
        password = json["password"].stringValue
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
        friends = json["friends"].arrayValue.map { Player(json: $0) }
        allClubs = json["allClubs"].arrayValue.map { $0.intValue }
        allHistoryGames = json["allHistoryGames"].arrayValue.map { Game(json: $0) }
        allUnfinishedGames = json["allUnfinishedGames"].arrayValue.map { Game(json: $0) }
        allEvents = json["allEvents"].arrayValue.map { $0.intValue }
        allSchedules = json["allSchedules"].arrayValue.map { Schedule(json: $0) }
        addresss = json["addresss"].arrayValue.map { $0.intValue }
        allOrders = json["allOrders"].arrayValue.map { $0.intValue }
        cart = json["cart"].intValue
        defaultAddress = Address(json: json["defaultAddress"])
        token = json["token"].stringValue
    }

    init() {
        self = User(json: JSON())
    }

    func toDictionary() -> [String: Any] {
        let dict: [String: Any] = [
            "id": id,
            "loginName": loginName,
            "password": password,
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
            "friends": friends.map { $0.toDictionary() },
            "allClubs": allClubs,
            "allHistoryGames": allHistoryGames.map { $0.toDictionary() },
            "allUnfinishedGames": allUnfinishedGames.map { $0.toDictionary() },
            "allEvents": allEvents,
            "allSchedules": allSchedules.map { $0.toDictionary() },
            "addresss": addresss,
            "allOrders": allOrders,
            "cart": cart,
            "defaultAddress": defaultAddress.toDictionary(),
            "token": token,
        ]

        return dict
    }

    init?(dictionary: [String: Any]) {
        guard let id = dictionary["id"] as? Int,
            let loginName = dictionary["loginName"] as? String,
            let password = dictionary["password"] as? String,
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
            let careerStatsDictionary = dictionary["careerStats"] as? [String: Any],
            let careerStats = Stats(dict: careerStatsDictionary),
            let friendsDictionaries = dictionary["friends"] as? [[String: Any]],
            let allClubsDictionaries = dictionary["allClubs"] as? [Int],
            let allHistoryGamesDictionaries = dictionary["allHistoryGames"] as? [[String: Any]],
            let allUnfinishedGamesDictionaries = dictionary["allUnfinishedGames"] as? [[String: Any]],
            let allEventsDictionaries = dictionary["allEvents"] as? [Int],
            let allSchedulesDictionaries = dictionary["allSchedules"] as? [[String: Any]],
            let addresssDictionaries = dictionary["addresss"] as? [Int],
            let ordersDictionaries = dictionary["allOrders"] as? [Int],
            let cartDictionaries = dictionary["cart"] as? Int,
            let defaultAddressDictionaries = dictionary["defaultAddress"] as? [String: Any],
            let token = dictionary["token"] as? String
        else {
            return nil
        }
        let friends = friendsDictionaries.compactMap { Player(dictionary: $0) }
        let allHistoryGames = allHistoryGamesDictionaries.compactMap { Game(dictionary: $0) }
        let allUnfinishedGames = allUnfinishedGamesDictionaries.compactMap { Game(dictionary: $0) }
        let allClubs = allClubsDictionaries
        let allEvents = allEventsDictionaries
        let allSchedules = allSchedulesDictionaries.compactMap { Schedule(dictionary: $0) }
        let defaultAddress = Address(dictionary: defaultAddressDictionaries)

        self = User(id: id, loginName: loginName, password: password, name: name, icon: icon, sex: sex, age: age, yearsPlayed: yearsPlayed, height: height, width: width, grip: grip, backhand: backhand, points: points, isAdult: isAdult, careerStats: careerStats, friends: friends, allClubs: allClubs, allHistoryGames: allHistoryGames, allUnfinishedGames: allUnfinishedGames, allEvents: allEvents, allSchedules: allSchedules, addresss: addresssDictionaries, allOrders: ordersDictionaries, cart: cartDictionaries, defaultAddress: defaultAddress ?? Address(), token: token)
    }

    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id &&
            lhs.loginName == rhs.loginName &&
            lhs.password == rhs.password &&
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
            lhs.careerStats == rhs.careerStats &&
            lhs.friends == rhs.friends &&
            lhs.allClubs == rhs.allClubs &&
            lhs.allHistoryGames == rhs.allHistoryGames &&
            lhs.allUnfinishedGames == rhs.allUnfinishedGames &&
            lhs.allEvents == rhs.allEvents &&
            lhs.allSchedules == rhs.allSchedules && lhs.allOrders == rhs.allOrders &&
            lhs.addresss == rhs.addresss && lhs.allOrders == rhs.allOrders && lhs.defaultAddress == rhs.defaultAddress && lhs.cart == rhs.cart
    }
}

struct signupResponse: Codable {
    var user: User
    var res: Bool
}

struct UserSignUpResponse: Codable {
    var code: Int
    var count: Int
    var data: signupResponse
}

struct UserResponse: Codable {
    var code: Int
    var count: Int
    var data: User
}
