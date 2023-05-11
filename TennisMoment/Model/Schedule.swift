//
//  Schedule.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/3/28.
//

import Foundation
import SwiftyJSON

struct Schedule: Codable, Equatable {
    var id: Int
    var startDate: TimeInterval
    var place: String
    var opponent: Player

    init(id: Int, startDate: TimeInterval, place: String, opponent: Player) {
        self.id = id
        self.startDate = startDate
        self.place = place
        self.opponent = opponent
    }

    init(json: JSON) {
        id = json["id"].intValue
        startDate = json["startDate"].doubleValue
        place = json["place"].stringValue
        opponent = Player(json: json["opponent"])
    }

    init() {
        self = Schedule(json: JSON())
    }

    // 将 Schedule 对象转换为字典
    func toDictionary() -> [String: Any] {
        let dictionary: [String: Any] = [
            "id": id,
            "startDate": startDate,
            "place": place,
            "opponent": opponent.toDictionary(),
        ]
        return dictionary
    }

    // 将字典转换为 Schedule 对象
    init?(dictionary: [String: Any]) {
        guard let id = dictionary["id"] as? Int, let startDate = dictionary["startDate"] as? TimeInterval,
            let place = dictionary["place"] as? String,
            let opponentDict = dictionary["opponent"] as? [String: Any],
            let opponent = Player(dictionary: opponentDict) else {
            return nil
        }
        self = Schedule(id: id, startDate: startDate, place: place, opponent: opponent)
    }

    static func == (lhs: Schedule, rhs: Schedule) -> Bool {
        return lhs.id == rhs.id && lhs.startDate == rhs.startDate &&
            lhs.place == rhs.place &&
            lhs.opponent == rhs.opponent
    }
}

struct ScheduleResponse: Codable {
    var code: Int
    var count: Int
    var msg: String
    var data: Schedule
}
