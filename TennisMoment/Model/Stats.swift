//
//  CareerStats.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/2/25.
//

import Foundation
import SwiftyJSON

struct statsData {
    var aces: Int
    var doubleFaults: Int
    var returnAces: Int
    var netPoints: Int
    var unforcedErrors: Int
    var forehandWinners: Int
    var backhandWinners: Int
    var firstServeIn: Int
    var firstServeWon: Int
    var secondServeIn: Int
    var secondServeWon: Int
    var firstReturnServeIn: Int
    var firstReturnServeWon: Int
    var secondReturnServeIn: Int
    var secondReturnServeWon: Int
    var breakPointSaved: Int
    var breakPointConvert: Int
    var serveGameWon: Int
    var returnGameWon: Int
    var servePointWon: Int
    var returnPointWon: Int
}

struct Stats: Codable, Equatable {
    var id: Int
    var aces: Int
    var doubleFaults: Int
    var servePoints: Int
    var firstServePoints: Int
    var firstServePointsIn: Int
    var firstServePointsWon: Int
    var secondServePointsIn: Int
    var secondServePointsWon: Int
    var breakPointsFaced: Int
    var breakPointsSaved: Int
    var serveGamesPlayed: Int
    var serveGamesWon: Int
    var returnAces: Int
    var returnServePoints: Int
    var firstServeReturnPoints: Int
    var firstServeReturnPointsIn: Int
    var firstServeReturnPointsWon: Int
    var secondServeReturnPointsIn: Int
    var secondServeReturnPointsWon: Int
    var breakPointsOpportunities: Int
    var breakPointsConverted: Int
    var returnGamesPlayed: Int
    var returnGamesWon: Int
    var netPoints: Int
    var unforcedErrors: Int
    var forehandWinners: Int
    var backhandWinners: Int

    init(id: Int, aces: Int, doubleFaults: Int, servePoints: Int, firstServePoints: Int, firstServePointsIn: Int, firstServePointsWon: Int, secondServePointsIn: Int, secondServePointsWon: Int, breakPointsFaced: Int, breakPointsSaved: Int, serveGamesPlayed: Int, serveGamesWon: Int, returnAces: Int, returnServePoints: Int, firstServeReturnPoints: Int, firstServeReturnPointsIn: Int, firstServeReturnPointsWon: Int, secondServeReturnPointsIn: Int, secondServeReturnPointsWon: Int, breakPointsOpportunities: Int, breakPointsConverted: Int, returnGamesPlayed: Int, returnGamesWon: Int, netPoints: Int, unforcedErrors: Int, forehandWinners: Int, backhandWinners: Int) {
        self.id = id
        self.aces = aces
        self.doubleFaults = doubleFaults
        self.servePoints = servePoints
        self.firstServePoints = firstServePoints
        self.firstServePointsIn = firstServePointsIn
        self.firstServePointsWon = firstServePointsWon
        self.secondServePointsIn = secondServePointsIn
        self.secondServePointsWon = secondServePointsWon
        self.breakPointsFaced = breakPointsFaced
        self.breakPointsSaved = breakPointsSaved
        self.serveGamesPlayed = serveGamesPlayed
        self.serveGamesWon = serveGamesWon
        self.returnAces = returnAces
        self.returnServePoints = returnServePoints
        self.firstServeReturnPoints = firstServeReturnPoints
        self.firstServeReturnPointsIn = firstServeReturnPointsIn
        self.firstServeReturnPointsWon = firstServeReturnPointsWon
        self.secondServeReturnPointsIn = secondServeReturnPointsIn
        self.secondServeReturnPointsWon = secondServeReturnPointsWon
        self.breakPointsOpportunities = breakPointsOpportunities
        self.breakPointsConverted = breakPointsConverted
        self.returnGamesPlayed = returnGamesPlayed
        self.returnGamesWon = returnGamesWon
        self.netPoints = netPoints
        self.unforcedErrors = unforcedErrors
        self.forehandWinners = forehandWinners
        self.backhandWinners = backhandWinners
    }

    init(json: JSON) {
        id = json["id"].intValue
        aces = json["aces"].intValue
        doubleFaults = json["doubleFaults"].intValue
        servePoints = json["servePoints"].intValue
        firstServePoints = json["firstServePoints"].intValue
        firstServePointsIn = json["firstServePointsIn"].intValue
        firstServePointsWon = json["firstServePointsWon"].intValue
        secondServePointsIn = json["secondServePointsIn"].intValue
        secondServePointsWon = json["secondServePointsWon"].intValue
        breakPointsFaced = json["breakPointsFaced"].intValue
        breakPointsSaved = json["breakPointsSaved"].intValue
        serveGamesPlayed = json["serveGamesPlayed"].intValue
        serveGamesWon = json["serveGamesWon"].intValue
        returnAces = json["returnAces"].intValue
        returnServePoints = json["returnServePoints"].intValue
        firstServeReturnPoints = json["firstServeReturnPoints"].intValue
        firstServeReturnPointsIn = json["firstServeReturnPointsIn"].intValue
        firstServeReturnPointsWon = json["firstServeReturnPointsWon"].intValue
        secondServeReturnPointsIn = json["secondServeReturnPointsIn"].intValue
        secondServeReturnPointsWon = json["secondServeReturnPointsWon"].intValue
        breakPointsOpportunities = json["breakPointsOpportunities"].intValue
        breakPointsConverted = json["breakPointsConverted"].intValue
        returnGamesPlayed = json["returnGamesPlayed"].intValue
        returnGamesWon = json["returnGamesWon"].intValue
        netPoints = json["netPoints"].intValue
        unforcedErrors = json["unforcedErrors"].intValue
        forehandWinners = json["forehandWinners"].intValue
        backhandWinners = json["backhandWinners"].intValue
    }

    func toJSON() -> JSON {
        return JSON([
            "id": self.id,
            "aces": self.aces,
            "doubleFaults": self.doubleFaults,
            "servePoints": self.servePoints,
            "firstServePoints": self.firstServePoints,
            "firstServePointsIn": self.firstServePointsIn,
            "firstServePointsWon": self.firstServePointsWon,
            "secondServePointsIn": self.secondServePointsIn,
            "secondServePointsWon": self.secondServePointsWon,
            "breakPointsFaced": self.breakPointsFaced,
            "breakPointsSaved": self.breakPointsSaved,
            "serveGamesPlayed": self.serveGamesPlayed,
            "serveGamesWon": self.serveGamesWon,
            "returnAces": self.returnAces,
            "returnServePoints": self.returnServePoints,
            "firstServeReturnPoints": self.firstServeReturnPoints,
            "firstServeReturnPointsIn": self.firstServeReturnPointsIn,
            "firstServeReturnPointsWon": self.firstServeReturnPointsWon,
            "secondServeReturnPointsIn": self.secondServeReturnPointsIn,
            "secondServeReturnPointsWon": self.secondServeReturnPointsWon,
            "breakPointsOpportunities": self.breakPointsOpportunities,
            "breakPointsConverted": self.breakPointsConverted,
            "returnGamesPlayed": self.returnGamesPlayed,
            "returnGamesWon": self.returnGamesWon,
            "netPoints": self.netPoints,
            "unforcedErrors": self.unforcedErrors,
            "forehandWinners": self.forehandWinners,
            "backhandWinners": self.backhandWinners,
        ])
    }

    func toDictionary() -> [String: Any] {
        let dict: [String: Any] = [
            "id": id,
            "aces": aces,
            "doubleFaults": doubleFaults,
            "servePoints": servePoints,
            "firstServePoints": firstServePoints,
            "firstServePointsIn": firstServePointsIn,
            "firstServePointsWon": firstServePointsWon,
            "secondServePointsIn": secondServePointsIn,
            "secondServePointsWon": secondServePointsWon,
            "breakPointsFaced": breakPointsFaced,
            "breakPointsSaved": breakPointsSaved,
            "serveGamesPlayed": serveGamesPlayed,
            "serveGamesWon": serveGamesWon,
            "returnAces": returnAces,
            "returnServePoints": returnServePoints,
            "firstServeReturnPoints": firstServeReturnPoints,
            "firstServeReturnPointsIn": firstServeReturnPointsIn,
            "firstServeReturnPointsWon": firstServeReturnPointsWon,
            "secondServeReturnPointsIn": secondServeReturnPointsIn,
            "secondServeReturnPointsWon": secondServeReturnPointsWon,
            "breakPointsOpportunities": breakPointsOpportunities,
            "breakPointsConverted": breakPointsConverted,
            "returnGamesPlayed": returnGamesPlayed,
            "returnGamesWon": returnGamesWon,
            "netPoints": netPoints,
            "unforcedErrors": unforcedErrors,
            "forehandWinners": forehandWinners,
            "backhandWinners": backhandWinners,
        ]
        return dict
    }

    init?(dict: [String: Any]) {
        guard let id = dict["id"] as? Int,
            let aces = dict["aces"] as? Int,
            let doubleFaults = dict["doubleFaults"] as? Int,
            let servePoints = dict["servePoints"] as? Int,
            let firstServePoints = dict["firstServePoints"] as? Int,
            let firstServePointsIn = dict["firstServePointsIn"] as? Int,
            let firstServePointsWon = dict["firstServePointsWon"] as? Int,
            let secondServePointsIn = dict["secondServePointsIn"] as? Int,
            let secondServePointsWon = dict["secondServePointsWon"] as? Int,
            let breakPointsFaced = dict["breakPointsFaced"] as? Int,
            let breakPointsSaved = dict["breakPointsSaved"] as? Int,
            let serveGamesPlayed = dict["serveGamesPlayed"] as? Int,
            let serveGamesWon = dict["serveGamesWon"] as? Int,
            let returnAces = dict["returnAces"] as? Int,
            let returnServePoints = dict["returnServePoints"] as? Int,
            let firstServeReturnPoints = dict["firstServeReturnPoints"] as? Int,
            let firstServeReturnPointsIn = dict["firstServeReturnPointsIn"] as? Int,
            let firstServeReturnPointsWon = dict["firstServeReturnPointsWon"] as? Int,
            let secondServeReturnPointsIn = dict["secondServeReturnPointsIn"] as? Int,
            let secondServeReturnPointsWon = dict["secondServeReturnPointsWon"] as? Int,
            let breakPointsOpportunities = dict["breakPointsOpportunities"] as? Int,
            let breakPointsConverted = dict["breakPointsConverted"] as? Int,
            let returnGamesPlayed = dict["returnGamesPlayed"] as? Int,
            let returnGamesWon = dict["returnGamesWon"] as? Int,
            let netPoints = dict["netPoints"] as? Int,
            let unforcedErrors = dict["unforcedErrors"] as? Int,
            let forehandWinners = dict["forehandWinners"] as? Int,
            let backhandWinners = dict["backhandWinners"] as? Int
        else {
            return nil
        }

        self.id = id
        self.aces = aces
        self.doubleFaults = doubleFaults
        self.servePoints = servePoints
        self.firstServePoints = firstServePoints
        self.firstServePointsIn = firstServePointsIn
        self.firstServePointsWon = firstServePointsWon
        self.secondServePointsIn = secondServePointsIn
        self.secondServePointsWon = secondServePointsWon
        self.breakPointsFaced = breakPointsFaced
        self.breakPointsSaved = breakPointsSaved
        self.serveGamesPlayed = serveGamesPlayed
        self.serveGamesWon = serveGamesWon
        self.returnAces = returnAces
        self.returnServePoints = returnServePoints
        self.firstServeReturnPoints = firstServeReturnPoints
        self.firstServeReturnPointsIn = firstServeReturnPointsIn
        self.firstServeReturnPointsWon = firstServeReturnPointsWon
        self.secondServeReturnPointsIn = secondServeReturnPointsIn
        self.secondServeReturnPointsWon = secondServeReturnPointsWon
        self.breakPointsOpportunities = breakPointsOpportunities
        self.breakPointsConverted = breakPointsConverted
        self.returnGamesPlayed = returnGamesPlayed
        self.returnGamesWon = returnGamesWon
        self.netPoints = netPoints
        self.unforcedErrors = unforcedErrors
        self.forehandWinners = forehandWinners
        self.backhandWinners = backhandWinners
    }

    init() {
        self = Stats(json: JSON())
    }

    static func == (lhs: Stats, rhs: Stats) -> Bool {
        return lhs.id == rhs.id &&
            lhs.aces == rhs.aces &&
            lhs.doubleFaults == rhs.doubleFaults &&
            lhs.servePoints == rhs.servePoints &&
            lhs.firstServePoints == rhs.firstServePoints &&
            lhs.firstServePointsIn == rhs.firstServePointsIn &&
            lhs.firstServePointsWon == rhs.firstServePointsWon &&
            lhs.secondServePointsIn == rhs.secondServePointsIn &&
            lhs.secondServePointsWon == rhs.secondServePointsWon &&
            lhs.breakPointsFaced == rhs.breakPointsFaced &&
            lhs.breakPointsSaved == rhs.breakPointsSaved &&
            lhs.serveGamesPlayed == rhs.serveGamesPlayed &&
            lhs.serveGamesWon == rhs.serveGamesWon &&
            lhs.returnAces == rhs.returnAces &&
            lhs.returnServePoints == rhs.returnServePoints &&
            lhs.firstServeReturnPoints == rhs.firstServeReturnPoints &&
            lhs.firstServeReturnPointsIn == rhs.firstServeReturnPointsIn &&
            lhs.firstServeReturnPointsWon == rhs.firstServeReturnPointsWon &&
            lhs.secondServeReturnPointsIn == rhs.secondServeReturnPointsIn &&
            lhs.secondServeReturnPointsWon == rhs.secondServeReturnPointsWon &&
            lhs.breakPointsOpportunities == rhs.breakPointsOpportunities &&
            lhs.breakPointsConverted == rhs.breakPointsConverted &&
            lhs.returnGamesPlayed == rhs.returnGamesPlayed &&
            lhs.returnGamesWon == rhs.returnGamesWon &&
            lhs.netPoints == rhs.netPoints &&
            lhs.unforcedErrors == rhs.unforcedErrors &&
            lhs.forehandWinners == rhs.forehandWinners &&
            lhs.backhandWinners == rhs.backhandWinners
    }

    func convertToRealStats() -> statsData {
        let firstServeIn = TMDataConvert.Divide(firstServePointsIn, by: firstServePoints)
        let firstServeWon = TMDataConvert.Divide(firstServePointsWon, by: firstServePointsIn)
        let secondServeIn = TMDataConvert.Divide(secondServePointsIn, by: servePoints - firstServePoints)
        let secondServeWon = TMDataConvert.Divide(secondServePointsWon, by: secondServePointsIn)
        let firstReturnServeIn = TMDataConvert.Divide(firstServeReturnPointsIn, by: firstServeReturnPoints)
        let firstReturnServeWon = TMDataConvert.Divide(firstServeReturnPointsWon, by: firstServeReturnPointsIn)
        let secondReturnServeIn = TMDataConvert.Divide(secondServeReturnPointsIn, by: returnServePoints - firstServeReturnPoints)
        let secondReturnServeWon = TMDataConvert.Divide(secondServeReturnPointsWon, by: secondServeReturnPointsIn)
        let breakPointSaved = TMDataConvert.Divide(breakPointsSaved, by: breakPointsFaced)
        let breakPointConvert = TMDataConvert.Divide(breakPointsConverted, by: breakPointsOpportunities)
        let serveGameWon = TMDataConvert.Divide(serveGamesWon, by: serveGamesPlayed)
        let returnGameWon = TMDataConvert.Divide(returnGamesWon, by: returnGamesPlayed)
        let servePointWon = TMDataConvert.Divide(firstServePointsWon + secondServePointsWon, by: firstServePointsIn + secondServePointsIn)
        let returnPointWon = TMDataConvert.Divide(firstServeReturnPointsWon + secondServeReturnPointsWon, by: firstServeReturnPointsIn + secondServeReturnPointsIn)

        return statsData(aces: aces, doubleFaults: doubleFaults, returnAces: returnAces, netPoints: netPoints, unforcedErrors: unforcedErrors, forehandWinners: forehandWinners, backhandWinners: backhandWinners, firstServeIn: firstServeIn.TwoBitsRem(), firstServeWon: firstServeWon.TwoBitsRem(), secondServeIn: secondServeIn.TwoBitsRem(), secondServeWon: secondServeWon.TwoBitsRem(), firstReturnServeIn: firstReturnServeIn.TwoBitsRem(), firstReturnServeWon: firstReturnServeWon.TwoBitsRem(), secondReturnServeIn: secondReturnServeIn.TwoBitsRem(), secondReturnServeWon: secondReturnServeWon.TwoBitsRem(), breakPointSaved: breakPointSaved.TwoBitsRem(), breakPointConvert: breakPointConvert.TwoBitsRem(), serveGameWon: serveGameWon.TwoBitsRem(), returnGameWon: returnGameWon.TwoBitsRem(), servePointWon: servePointWon.TwoBitsRem(), returnPointWon: returnPointWon.TwoBitsRem())
    }
}
