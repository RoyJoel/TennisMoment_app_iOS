//
//  TMClubRequest.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/4/13.
//

import Foundation

class TMClubRequest {
    static func getInfos(ids: [Int], completionHandler: @escaping ([Club]) -> Void) {
        TMNetWork.post("/club/getInfos", dataParameters: ["ids": ids]) { json in
            guard let json = json else {
                completionHandler([])
                return
            }
            completionHandler(json.arrayValue.map { Club(json: $0) })
        }
    }
}
