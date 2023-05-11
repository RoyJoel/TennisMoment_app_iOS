//
//  Event.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/3/19.
//

import Foundation
import SwiftyJSON

struct Event: Codable, Equatable {
    var id: Int
    var icon: String
    var name: String
    var startDate: TimeInterval
    var endDate: TimeInterval
    var level: EventLevel
    var draw: [Player]
    var schedule: [[Game]]

    init(id: Int, icon: String, name: String, startDate: TimeInterval, endDate: TimeInterval, level: EventLevel, draw: [Player], schedule: [[Game]]) {
        self.id = id
        self.icon = icon
        self.name = name
        self.startDate = startDate
        self.endDate = endDate
        self.level = level
        self.draw = draw
        self.schedule = schedule
    }

    init(json: JSON) {
        id = json["id"].intValue
        icon = json["icon"].stringValue
        name = json["name"].stringValue
        startDate = json["startDate"].doubleValue
        endDate = json["endDate"].doubleValue
        level = EventLevel(rawValue: json["level"].intValue) ?? .series15
        draw = json["draw"].arrayValue.map { Player(json: $0) }
        schedule = json["schedule"].arrayValue.map { $0.arrayValue.map { Game(json: $0) } }
    }

    init() {
        self = Event(json: JSON())
    }

    init?(dict: [String: Any]) {
        guard let id = dict["id"] as? Int,
            let icon = dict["icon"] as? String,
            let name = dict["name"] as? String,
            let startDate = dict["startDate"] as? TimeInterval,
            let endDate = dict["endDate"] as? TimeInterval,
            let levelString = dict["level"] as? Int,
            let level = EventLevel(rawValue: levelString),
            let drawDicts = dict["draw"] as? [[String: Any]],
            let scheduleDicts = dict["schedule"] as? [[[String: Any]]]
        else {
            return nil
        }

        let draw = drawDicts.compactMap { Player(dictionary: $0) }
        let schedule = scheduleDicts.map { $0.compactMap { Game(dictionary: $0) } }

        self = Event(id: id, icon: icon, name: name, startDate: startDate, endDate: endDate, level: level, draw: draw, schedule: schedule)
    }

    func toDictionary() -> [String: Any] {
        let drawDicts = draw.map { Player(dictionary: $0.toDictionary()) }
        let scheduleDicts = schedule.map { $0.map { Game(dictionary: $0.toDictionary()) } }

        return [
            "id": id,
            "icon": icon,
            "name": name,
            "startDate": startDate,
            "endDate": endDate,
            "level": level.rawValue,
            "draw": drawDicts,
            "schedule": scheduleDicts,
        ]
    }

    static func == (lhs: Event, rhs: Event) -> Bool {
        return lhs.id == rhs.id &&
            lhs.icon == rhs.icon &&
            lhs.name == rhs.name &&
            lhs.startDate == rhs.startDate &&
            lhs.endDate == rhs.endDate &&
            lhs.level == rhs.level &&
            lhs.draw == rhs.draw &&
            lhs.schedule == rhs.schedule
    }
}

/// 赛事分为15系列，18系列，25系列，45系列，55系列，75系列，125系列，250系列，350系列，500系列，1000系列，大满贯系列，年终系列
/// 15系列-125系列为常规赛事，每周两站，在所有加盟俱乐部开设
/// 250系列，每周一站，所有一二线城市每年开设一站
/// 350系列，开设在全国网球氛围较好的城市，每年32场
/// 500系列，开设在所有新一线城市，每年15场
/// 1000系列，开设在全国网球氛围较好的城市，每年9场
/// 大满贯系列，开设在北京，成都，上海，深圳，每年4场
/// 年终系列，开设在年终排名第一所在的城市，每年一场
enum EventLevel: Int, Codable {
    /// 8签小组赛制，分为两组，快四无占先，每组前二进半决赛，并改为淘汰赛制，小组赛出线2分，半决赛胜者5分，亚军10分，冠军15分，每周两场
    case series15 = 0
    /// 12签小组赛制，分为四组，快四无占先，每组第一进半决赛，并改为淘汰赛制，小组赛出线3分，半决赛胜者6分，亚军12分，冠军18分，每周两场
    case series18 = 2
    /// 16签小组赛制，分为四组，快四无占先，每组前二进半决赛，并改为淘汰赛制，小组赛出线2分，八分之一胜者5分，半决赛胜者10分，亚军16分，冠军25分，每周两场
    case series25 = 5
    /// 8签小组赛制，分为两组，快四无占先，每组前二进半决赛，并改为淘汰赛制，小组赛出线6分，半决赛胜者15分，亚军30分，冠军45分，每周两场
    case series45 = 15
    /// 12签小组赛制，分为四组，快四无占先，每组第一进半决赛，并改为淘汰赛制，小组赛出线10分，半决赛胜者30分，亚军50分，冠军75分，每周两场
    case series75 = 18
    /// 8签小组赛制，分为两组，快四无占先，每组前二进半决赛，并改为淘汰赛制，小组赛出线15分，半决赛胜者45分，亚军80分，冠军125分，每周两场
    case series125 = 25
    /// 16签淘汰赛制，16进8: 20分，8进4：45分，半决赛胜者90分，亚军150分，冠军250分，每周一场
    case TM250 = 45
    /// 28签淘汰赛制，28进16：15分，16进8：35分，8进4：70分，半决赛胜者180分，亚军260分，冠军350分，每年32场
    case TM350 = 50
    /// 32签淘汰赛制，32进16：20分，16进8：45分，8进4：90分，半决赛胜者225分，亚军340分，冠军500分，每年15场
    case TM500 = 55
    /// 64签淘汰赛制，64进32：10分，32进16：45分，16进8：90分，8进4：180分，半决赛胜者360分，亚军600分，冠军1000分，每年9场
    case TMaster = 60
    /// 128签淘汰赛制，128进64：10分，64进32：70分，32进16：130分，16进8：240分，8进4：430分，半决赛胜者780分，亚军1300分，冠军2000分，每年4场
    case TMGrandSlam = 65
    /// 8签小组赛制，分为两组，快四无占先，每组前二进半决赛，并改为淘汰赛制，小组赛出线200分，半决赛胜者600分，亚军1100分，冠军1500分
    case TMfinals = 75
}
