//
//  Game.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/2/25.
//

import CoreLocation
import Foundation
import SwiftyJSON

struct Game: Codable, Equatable {
    var id: Int
    var place: String
    var surface: SurfaceType
    var setNum: Int
    var gameNum: Int
    var round: Int
    var isGoldenGoal: Bool
    var isPlayer1Serving: Bool
    var isPlayer1Left: Bool
    var isChangePosition: Bool
    var startDate: TimeInterval
    var endDate: TimeInterval
    var player1: Player
    var player1Stats: Stats
    var player2: Player
    var player2Stats: Stats
    var isPlayer1FirstServe: Bool
    var isPlayer2FirstServe: Bool
    var result: [[[Int]]]

    init(id: Int, place: String, surface: SurfaceType, setNum: Int, gameNum: Int, round: Int, isGoldenGoal: Bool, isPlayer1Serving: Bool, isPlayer1Left: Bool, isChangePosition: Bool, startDate: TimeInterval, endDate: TimeInterval, player1: Player, player1Stats: Stats, player2: Player, player2Stats: Stats, isPlayer1FirstServe: Bool, isPlayer2FirstServe: Bool, result: [[[Int]]]) {
        self.id = id
        self.place = place
        self.surface = surface
        self.setNum = setNum
        self.gameNum = gameNum
        self.round = round
        self.isGoldenGoal = isGoldenGoal
        self.isPlayer1Serving = isPlayer1Serving
        self.isPlayer1Left = isPlayer1Left
        self.isChangePosition = isChangePosition
        self.startDate = startDate
        self.endDate = endDate
        self.player1 = player1
        self.player1Stats = player1Stats
        self.player2 = player2
        self.player2Stats = player2Stats
        self.isPlayer1FirstServe = isPlayer1FirstServe
        self.isPlayer2FirstServe = isPlayer2FirstServe
        self.result = result
    }

    init(json: JSON) {
        id = json["id"].intValue
        place = json["place"].stringValue
        surface = SurfaceType(rawValue: json["surface"].stringValue) ?? .hard
        setNum = json["setNum"].intValue
        gameNum = json["gameNum"].intValue
        round = json["round"].intValue
        isGoldenGoal = json["isGoldenGoal"].boolValue
        isPlayer1Serving = json["isPlayer1Serving"].boolValue
        isPlayer1Left = json["isPlayer1Left"].boolValue
        isChangePosition = json["isChangePosition"].boolValue
        startDate = json["startDate"].doubleValue
        endDate = json["endDate"].doubleValue
        player1 = Player(json: json["player1"])
        player1Stats = Stats(json: json["player1Stats"])
        player2 = Player(json: json["player2"])
        player2Stats = Stats(json: json["player2Stats"])
        isPlayer1FirstServe = json["isPlayer1FirstServe"].boolValue
        isPlayer2FirstServe = json["isPlayer2FirstServe"].boolValue
        if let array = json["result"].array {
            result = array.map { subarray in
                subarray.arrayValue.map { array in
                    array.arrayValue.map { num in
                        num.intValue
                    }
                }
            }
        } else {
            result = [[]]
        }
    }

    init() {
        self = Game(json: JSON())
    }

    init?(dictionary: [String: Any]) {
        guard let id = dictionary["id"] as? Int,
            let place = dictionary["place"] as? String,
            let surface = dictionary["surface"] as? String,
            let surfaceType = SurfaceType(rawValue: surface),
            let setNum = dictionary["setNum"] as? Int,
            let gameNum = dictionary["gameNum"] as? Int,
            let round = dictionary["round"] as? Int,
            let isGoldenGoal = dictionary["isGoldenGoal"] as? Bool,
            let isPlayer1Serving = dictionary["isPlayer1Serving"] as? Bool,
            let isPlayer1Left = dictionary["isPlayer1Left"] as? Bool,
            let isChangePosition = dictionary["isChangePosition"] as? Bool,
            let startDate = dictionary["startDate"] as? TimeInterval,
            let endDate = dictionary["endDate"] as? TimeInterval,
            let player1Dict = dictionary["player1"] as? [String: Any],
            let player1StatsDict = dictionary["player1Stats"] as? [String: Any],
            let player2Dict = dictionary["player2"] as? [String: Any],
            let player2StatsDict = dictionary["player2Stats"] as? [String: Any],
            let isPlayer1FirstServe = dictionary["isPlayer1FirstServe"] as? Bool,
            let isPlayer2FirstServe = dictionary["isPlayer2FirstServe"] as? Bool,
            let result = dictionary["result"] as? [[[Int]]]
        else {
            return nil
        }

        guard let player1 = Player(dictionary: player1Dict),
            let player1Stats = Stats(dict: player1StatsDict),
            let player2 = Player(dictionary: player2Dict),
            let player2Stats = Stats(dict: player2StatsDict)
        else {
            return nil
        }

        self.init(id: id, place: place, surface: surfaceType, setNum: setNum, gameNum: gameNum, round: round, isGoldenGoal: isGoldenGoal, isPlayer1Serving: isPlayer1Serving, isPlayer1Left: isPlayer1Left, isChangePosition: isChangePosition, startDate: startDate, endDate: endDate, player1: player1, player1Stats: player1Stats, player2: player2, player2Stats: player2Stats, isPlayer1FirstServe: isPlayer1FirstServe, isPlayer2FirstServe: isPlayer2FirstServe, result: result)
    }

    func toDictionary() -> [String: Any] {
        var dict: [String: Any] = [:]
        dict["id"] = id
        dict["place"] = place
        dict["surface"] = surface.rawValue
        dict["setNum"] = setNum
        dict["gameNum"] = gameNum
        dict["round"] = round
        dict["isGoldenGoal"] = isGoldenGoal
        dict["isPlayer1Serving"] = isPlayer1Serving
        dict["isPlayer1Left"] = isPlayer1Left
        dict["isChangePosition"] = isChangePosition
        dict["startDate"] = startDate
        dict["endDate"] = endDate
        dict["player1"] = player1.toDictionary()
        dict["player1Stats"] = player1Stats.toDictionary()
        dict["player2"] = player2.toDictionary()
        dict["player2Stats"] = player2Stats.toDictionary()
        dict["isPlayer1FirstServe"] = isPlayer1FirstServe
        dict["isPlayer2FirstServe"] = isPlayer2FirstServe
        dict["result"] = result
        return dict
    }

    static func == (lhs: Game, rhs: Game) -> Bool {
        return lhs.id == rhs.id &&
            lhs.place == rhs.place &&
            lhs.surface == rhs.surface &&
            lhs.setNum == rhs.setNum &&
            lhs.gameNum == rhs.gameNum &&
            lhs.round == rhs.round &&
            lhs.isGoldenGoal == rhs.isGoldenGoal &&
            lhs.isPlayer1Serving == rhs.isPlayer1Serving &&
            lhs.isPlayer1Left == rhs.isPlayer1Left &&
            lhs.isChangePosition == rhs.isChangePosition &&
            lhs.startDate == rhs.startDate &&
            lhs.endDate == rhs.endDate &&
            lhs.player1 == rhs.player1 &&
            lhs.player1Stats == rhs.player1Stats &&
            lhs.player2 == rhs.player2 &&
            lhs.player2Stats == rhs.player2Stats &&
            lhs.isPlayer1FirstServe == rhs.isPlayer1FirstServe &&
            lhs.isPlayer2FirstServe == rhs.isPlayer2FirstServe &&
            lhs.result == rhs.result
    }
}

enum SurfaceType: String, Codable, CaseIterable {
    case hard
    case grass
    case clay
}

struct GameRequest: Codable {
    var id: Int
    var place: String
    var surface: SurfaceType
    var setNum: Int
    var gameNum: Int
    var round: Int
    var isGoldenGoal: Bool
    var isPlayer1Serving: Bool
    var isPlayer1Left: Bool
    var isChangePosition: Bool
    var startDate: TimeInterval
    var endDate: TimeInterval?
    var player1Id: Int
    var player1StatsId: Int
    var player2Id: Int
    var player2StatsId: Int
    var isPlayer1FirstServe: Bool
    var isPlayer2FirstServe: Bool
    var result: [[[Int]]]

    init(id: Int, place: String, surface: SurfaceType, setNum: Int, gameNum: Int, round: Int, isGoldenGoal: Bool, isPlayer1Serving: Bool, isPlayer1Left: Bool, isChangePosition: Bool, startDate: TimeInterval, endDate: TimeInterval? = nil, player1Id: Int, player1StatsId: Int, player2Id: Int, player2StatsId: Int, isPlayer1FirstServe: Bool, isPlayer2FirstServe: Bool, result: [[[Int]]]) {
        self.id = id
        self.place = place
        self.surface = surface
        self.setNum = setNum
        self.gameNum = gameNum
        self.round = round
        self.isGoldenGoal = isGoldenGoal
        self.isPlayer1Serving = isPlayer1Serving
        self.isPlayer1Left = isPlayer1Left
        self.isChangePosition = isChangePosition
        self.startDate = startDate
        self.endDate = endDate
        self.player1Id = player1Id
        self.player1StatsId = player1StatsId
        self.player2Id = player2Id
        self.player2StatsId = player2StatsId
        self.isPlayer1FirstServe = isPlayer1FirstServe
        self.isPlayer2FirstServe = isPlayer2FirstServe
        self.result = result
    }

    init(json: JSON) {
        id = json["id"].intValue
        place = json["place"].stringValue
        surface = SurfaceType(rawValue: json["surface"].stringValue) ?? .hard
        setNum = json["setNum"].intValue
        gameNum = json["gameNum"].intValue
        round = json["round"].intValue
        isGoldenGoal = json["isGoldenGoal"].boolValue
        isPlayer1Serving = json["isPlayer1Serving"].boolValue
        isPlayer1Left = json["isPlayer1Left"].boolValue
        isChangePosition = json["isChangePosition"].boolValue
        startDate = json["startDate"].doubleValue
        endDate = json["endDate"].doubleValue
        player1Id = json["player1Id"].intValue
        player1StatsId = json["player1Stats"].intValue
        player2Id = json["player2"].intValue
        player2StatsId = json["player2Stats"].intValue
        isPlayer1FirstServe = json["isPlayer1FirstServe"].boolValue
        isPlayer2FirstServe = json["isPlayer2FirstServe"].boolValue
        if let array = json["result"].array {
            result = array.map { subarray in
                subarray.arrayValue.map { array in
                    array.arrayValue.map { num in
                        num.intValue
                    }
                }
            }
        } else {
            result = [[]]
        }
    }
}

struct GameResponse: Codable {
    var code: Int
    var count: Int
    var msg: String
    var data: Game
}
