//
//  HiveEnums.swift
//  Hive.ai
//
//  Created by shashank Mishra on 03/01/24.
//

import Foundation
enum APIRequestType {
    case get
    case post
    case put
    case delete
}
extension APIRequestType: RawRepresentable {
    typealias RawValue = String
    init?(rawValue: RawValue) {
        switch rawValue {
        case "G":
            self = .get
        case "P":
            self = .post
        case "PU":
            self = .put
        case "D":
            self = .delete
        default:
            return nil
        }
    }
    var rawValue: RawValue {
        switch self {
        case .get: return "get"
        case .post: return "post"
        case .put: return "put"
        case .delete: return "delete"
        }
    }
}
