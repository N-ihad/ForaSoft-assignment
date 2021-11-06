//
//  PersistenceManager.swift
//  ForaSoft-assignment
//
//  Created by Nihad on 1/14/21.
//

import Foundation
import RealmSwift

struct PersistenceManager {

    static let shared = PersistenceManager()

    var searchedAlbums: [String] {
        do {
            let realm = try Realm()

            return realm.objects(SearchedAlbum.self).map { $0.title }.reversed()
        } catch {
            print(error)
            return []
        }
    }

    private init() { }

    func addSearchedAlbum(_ title: String) {
        do {
            let realm = try Realm()

            try realm.write {
                realm.add(SearchedAlbum(title: title))
            }
        } catch {
            print(error)
        }
    }

    func deleteSearchedAlbum(_ title: String) {
        do {
            let realm = try Realm()

            guard let searchedAlbum = realm.objects(SearchedAlbum.self).first(where: { $0.title == title }) else {
                return
            }

            try realm.write {
                realm.delete(searchedAlbum)
            }
        } catch {
            print(error)
        }
    }
}
