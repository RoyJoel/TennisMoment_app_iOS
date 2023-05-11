//
//  TMGameRequest.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/3/2.
//

import Alamofire
import CoreLocation
import Foundation
import SwiftyJSON

class TMGameRequest {
    static func addGame(game: GameRequest, completionHandler: @escaping (Game?) -> Void) {
        TMNetWork.post("/game/add", dataParameters: game, responseBindingType: GameResponse.self) { response in
            guard let res = response else {
                completionHandler(nil)
                return
            }
            completionHandler(res.data)
        }
    }

    static func updateGameAndStats(game: Game, completionHandler: @escaping (Game) -> Void) {
        TMNetWork.post("/game/update", dataParameters: game, responseBindingType: GameResponse.self) { response in
            guard let res = response else {
                return
            }
            completionHandler(res.data)
        }
    }

    static func SearchRecentGames(playerId: Int, num: Int, isCompleted: Bool, completionHandler: @escaping ([Game]) -> Void) {
        TMNetWork.post("/game/searchRecent", dataParameters: [
            "id": playerId,
            "limit": num,
            "isCompleted": isCompleted,
        ]) { json in
            guard let json = json else {
                return
            }
            completionHandler(json.arrayValue.map { Game(json: $0) })
        }
    }

    static func searchh2h(for player1Id: Int, and player2Id: Int, completionHandler: @escaping ([Game]) -> Void) {
        TMNetWork.post("/game/h2h", dataParameters: [
            "player1Id": player1Id,
            "player2Id": player2Id,
        ]) { json in
            guard let json = json else {
                return
            }
            completionHandler(json.arrayValue.map { Game(json: $0) })
        }
    }

    static func searchAllGames(for playerId: Int, completionHandler: @escaping ([Game]) -> Void) {
        TMNetWork.post("/game/searchAll", dataParameters: [
            "id": playerId,
        ]) { json in
            guard let json = json else {
                return
            }
            completionHandler(json.arrayValue.map { Game(json: $0) })
        }
    }
}
