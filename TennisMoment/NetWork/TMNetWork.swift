//
//  TMNetWork.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/2/28.
//

import Alamofire
import Foundation
import SwiftyJSON

class TMNetWork {
    static let tennisMomentURL = "http://localhost:8080"

    static func get(_ parameters: String, headers: HTTPHeaders? = nil, completionHandler: @escaping (JSON?, Error?) -> Void) {
        AF.request(URL(string: tennisMomentURL + parameters)!, headers: headers).response { response in
            guard response.response?.statusCode != 401 else {
                completionHandler(nil, TMNetWorkError.authError("认证失败"))
                return
            }
            guard let jsonData = response.data else {
                completionHandler(nil, nil)
                return
            }
            let json = try? JSON(data: jsonData)
            completionHandler(json?["data"], nil)
        }
    }

    static func post<T: Decodable>(_ URLParameters: String, dataParameters: Encodable, responseBindingType: T.Type, completionHandler: @escaping (T?) -> Void) {
        guard let json = try? JSONEncoder().encode(dataParameters) else {
            return // 序列化失败，处理错误
        }

        guard let dictionary = try? JSONSerialization.jsonObject(with: json, options: []) as? [String: Any] else {
            return // 转换失败，处理错误
        }

        AF.request(URL(string: tennisMomentURL + URLParameters)!, method: .post, parameters: dictionary, encoding: JSONEncoding.default).responseDecodable(of: responseBindingType.self) { response in
            switch response.result {
            case let .success(T):
                // 成功解码，处理 Response 对象
                completionHandler(T)
            case .failure:
                // 解码失败，处理错误
                completionHandler(nil)
            }
        }
    }

    static func post(_ URLParameters: String, dataParameters: Encodable, completionHandler: @escaping (JSON?) -> Void) {
        guard let json = try? JSONEncoder().encode(dataParameters) else {
            return // 序列化失败，处理错误
        }

        guard let dictionary = try? JSONSerialization.jsonObject(with: json, options: []) as? [String: Any] else {
            return // 转换失败，处理错误
        }

        AF.request(URL(string: tennisMomentURL + URLParameters)!, method: .post, parameters: dictionary, encoding: JSONEncoding.default).response { response in
            guard let jsonData = response.data else {
                completionHandler(nil)
                return
            }
            let json = try? JSON(data: jsonData)
            completionHandler(json?["data"])
        }
    }

    static func post<T: Decodable>(_ URLParameters: String, dataParameters: Parameters?, responseBindingType: T.Type, completionHandler: @escaping (T?) -> Void) {
        AF.request(URL(string: tennisMomentURL + URLParameters)!, method: .post, parameters: dataParameters, encoding: JSONEncoding.default).responseDecodable(of: responseBindingType.self) { response in
            switch response.result {
            case let .success(T):
                // 成功解码，处理 Response 对象
                completionHandler(T)
            case .failure:
                // 解码失败，处理错误
                completionHandler(nil)
            }
        }
    }

    static func post(_ URLParameters: String, dataParameters: Parameters?, completionHandler: @escaping (JSON?) -> Void) {
        AF.request(URL(string: tennisMomentURL + URLParameters)!, method: .post, parameters: dataParameters, encoding: JSONEncoding.default).response { response in
            guard let jsonData = response.data else {
                completionHandler(nil)
                return
            }
            let json = try? JSON(data: jsonData)
            completionHandler(json?["data"])
        }
    }
}

enum TMNetWorkError: Error {
    case authError(String)
    case netError(String)
}
