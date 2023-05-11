//
//  TMStatsRequest.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/3/4.
//

import Foundation

class TMStatsRequest {
    static func searchStats(id: Int, completionHandler: @escaping (Stats) -> Void) {
        TMNetWork.post("/stats/search", dataParameters: ["id": id]) { json in
            guard let json = json else {
                return
            }
            completionHandler(Stats(json: json))
        }
    }
}
