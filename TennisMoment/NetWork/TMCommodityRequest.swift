//
//  TMCommodityRequest.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/6/6.
//

import Foundation

class TMCommodityRequest {
    static func getAll(completionHandler: @escaping ([Commodity]) -> Void) {
        TMNetWork.get("/commodity/getAll") { json, _ in
            guard let json = json else {
                return
            }
            TMUser.commodities = json.arrayValue.compactMap { Commodity(json: $0) }
            completionHandler(json.arrayValue.compactMap { Commodity(json: $0) })
        }
    }
}
