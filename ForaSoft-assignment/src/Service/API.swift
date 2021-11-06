//
//  API.swift
//  ForaSoft-assignment
//
//  Created by Nihad on 1/13/21.
//

import Moya

enum API {
    case search(query: String)
}

extension API: TargetType {

    var baseURL: URL {
        guard let url = URL(string: "https://itunes.apple.com/") else {
            fatalError()
        }
        return url
    }

    var path: String {
        switch self {
        case .search:
            return "search/"
        }
    }

    var method: Method {
        .get
    }

    var sampleData: Data {
        Data()
    }

    var task: Task {
        switch self {
        case .search(let query):
            return .requestParameters(
                parameters: ["term" : query, "entity" : "album"],
                encoding: URLEncoding.queryString
            )
        }
    }

    var headers: [String : String]? {
        nil
    }
}
