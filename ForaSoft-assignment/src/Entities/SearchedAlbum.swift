//
//  SearchedAlbums.swift
//  ForaSoft-assignment
//
//  Created by Nihad on 1/15/21.
//

import RealmSwift

final class SearchedAlbum: Object {
    @objc dynamic var title = ""

    convenience init(title: String) {
        self.init()
        self.title = title
    }
}
