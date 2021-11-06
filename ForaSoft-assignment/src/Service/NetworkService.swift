//
//  NetworkService.swift
//  ForaSoft-assignment
//
//  Created by Nihad on 1/13/21.
//

import Moya
import SwiftyJSON
import Dispatch

protocol Networkable {
    var provider: MoyaProvider<API> { get }

    func fetchAlbums(withTitle title: String, completion: @escaping (Result<[Album], Error>) -> ())
}

final class NetworkService: Networkable {

    static let shared = NetworkService()

    var provider = MoyaProvider<API>(plugins: [NetworkLoggerPlugin()])

    private init() { }

    func fetchAlbums(withTitle title: String, completion: @escaping (Result<[Album], Error>) -> ()) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in

            self?.provider.request(.search(query: title)) { result in

                switch result {
                case let .success(response):
                    let results = Utilities.parseJsonData(response.data)
                    DispatchQueue.main.async {
                        completion(.success(results))
                    }
                case let .failure(error):
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            }
        }
    }
}
