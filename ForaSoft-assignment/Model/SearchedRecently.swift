//
//  SearchedRecently.swift
//  ForaSoft-assignment
//
//  Created by Nihad on 1/15/21.
//

import RealmSwift

class SearchedRecently: Object {
    @objc dynamic var name: String = "Main"
    let queries = List<String>()
}
