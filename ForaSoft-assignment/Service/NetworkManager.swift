//
//  NetworkManager.swift
//  ForaSoft-assignment
//
//  Created by Nihad on 1/13/21.
//

import Moya
import SwiftyJSON

protocol Networkable {
    var provider: MoyaProvider<API> { get }
    
    func fetchSearchResult(query: String, completion: @escaping (Result<[Album], Error>) -> ())
}

class NetworkManager: Networkable {
    var provider = MoyaProvider<API>(plugins: [NetworkLoggerPlugin()])
    static let shared = NetworkManager()
    
    private init() { }
    
    func fetchSearchResult(query: String, completion: @escaping (Result<[Album], Error>) -> ()) {
        provider.request(.search(query: query)) { result in
            switch result {
            case let .success(response):
                let results = Utilities().txtJSONToSwiftAlbumObjects(txtData: response.data)
                completion(.success(results))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
}

//enum NetworkError: Error {
//    case notFound
//    case unexpectedError
//}
