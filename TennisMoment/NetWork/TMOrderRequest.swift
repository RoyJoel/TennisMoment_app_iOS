//
//  TMOrderRequest.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/6/6.
//

import Foundation

class TMOrderRequest {
    static func getInfos(id: Int, completionHandler: @escaping ([Order]) -> Void) {
        TMNetWork.post("/order/getInfos", dataParameters: ["id": id]) { json in
            guard let json = json else {
                return
            }
            completionHandler(json.arrayValue.map { Order(json: $0) })
        }
    }

    static func addOrder(order: OrderRequest, completionHandler: @escaping (Int) -> Void) {
        TMNetWork.post("/order/add", dataParameters: order) { json in
            guard let json = json else {
                return
            }
            TMUser.user.allOrders.append(json.intValue)
            completionHandler(json.intValue)
        }
    }

    static func updateOrder(order: OrderRequest, completionHandler: @escaping (Int) -> Void) {
        TMNetWork.post("/order/update", dataParameters: order) { json in
            guard let json = json else {
                return
            }
            TMUser.user.allOrders.append(json.intValue)
            completionHandler(json.intValue)
        }
    }

    static func deleteOrder(id: Int, completionHandler: @escaping (Int) -> Void) {
        TMNetWork.post("/order/update", dataParameters: ["id": id]) { json in
            guard let json = json else {
                return
            }
            TMUser.user.allOrders.removeAll(where: { $0 == id })
            completionHandler(json.intValue)
        }
    }
}
