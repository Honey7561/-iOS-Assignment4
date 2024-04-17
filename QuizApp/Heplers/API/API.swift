//
//  API.swift
//  Squeezee
//
//  Created by user238851 on 13/04/24.
//

import Foundation

// MARK: - API
enum API {
    case api
}

// MARK: - APIProtocol
extension API: APIProtocol {
    var baseURL: String {
        "https://opentdb.com/"
    }
    
    var path: String {
        switch self {
        case .api:
            return "api.php?amount=10&category=9&difficulty=easy&type=boolean"
        }
    }
    
    var method: APIMethod {
        switch self {
        case .api:
            return .get
        }
    }
    
    var task: Request {
        switch self {
        case .api:
            return .requestPlain
        }
    }
    
    var header: [String: String] {
        switch self {
        case .api:
            return [
                "Content-Type" : "application/json"
            ]
        }
    }
}
