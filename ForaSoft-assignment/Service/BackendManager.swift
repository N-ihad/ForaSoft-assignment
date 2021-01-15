//
//  BackendManager.swift
//  ForaSoft-assignment
//
//  Created by Nihad on 1/14/21.
//

import Foundation
import RealmSwift

class BackendManager {
    
    static let shared = BackendManager()
    
    private init() { }
    
    func addQueryToRealmDB(query: String) {
        do {
            let realm = try Realm()
            
            if let searchedRecently = realm.objects(SearchedRecently.self).first {
                guard searchedRecently.queries.first(where: { $0.lowercased() == query.lowercased()}) == nil else { return }
                try realm.write {
                    searchedRecently.queries.append(query)
                }
            } else {
                let searchedRecently = SearchedRecently()
                searchedRecently.queries.append(query)
                try realm.write {
                    realm.add(searchedRecently)
                }
            }
        } catch {
            print(error)
        }
    }
    
    func getRecentSearchedQueries() -> [String] {
        do {
            let realm = try Realm()
            guard let searchedRecently = realm.objects(SearchedRecently.self).first else { return [] }
            var queries = [String]()
            searchedRecently.queries.forEach { queries.append($0) }
            return queries
        } catch {
            print(error)
            return []
        }
    }
    
    func deleteRecentSearchedQuery(with name: String) {
        do {
            let realm = try Realm()
            guard let searchedRecently = realm.objects(SearchedRecently.self).first else { return }
            let index = searchedRecently.queries.firstIndex(where: { $0 == name })!
            try realm.write {
                searchedRecently.queries.remove(at: index)
            }
        } catch {
            print(error)
        }
    }
    
}
