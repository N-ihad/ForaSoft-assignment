//
//  Helper.swift
//  ForaSoft-assignment
//
//  Created by Nihad on 1/14/21.
//

import Foundation
import SwiftyJSON

struct Helper {
    static func parseJsonData(_ data: Data) -> [Album] {
        let json = JSON(parseJSON: String(decoding: data, as: UTF8.self))
        let albumsToParse = json.dictionaryValue["results"] ?? []

        var albums = [Album]()
        for album in albumsToParse.array ?? [] {
            let album = Album(
                artistID: album.dictionary?["artistId"]?.int ?? 0,
                collectionID: album.dictionary?["collectionId"]?.int ?? 0,
                artistName: album.dictionary?["artistName"]?.string ?? "",
                collectionName: album.dictionary!["collectionName"]?.string ?? "",
                collectionViewURL: album.dictionary!["collectionViewUrl"]?.string ?? "",
                artworkURL: album.dictionary!["artworkUrl60"]?.string ?? "",
                collectionPrice: album.dictionary!["collectionPrice"]?.double ?? 0,
                collectionExplicitness: album.dictionary!["collectionExplicitness"]?.string ?? "",
                trackCount: album.dictionary?["trackCount"]?.int ?? 0,
                country: album.dictionary?["country"]?.string ?? "",
                releaseDate: String(album.dictionary?["releaseDate"]?.string?.prefix(4) ?? ""),
                primaryGenreName: album.dictionary?["primaryGenreName"]?.string ?? ""
            )
            albums.append(album)
        }
        return albums
    }

    static func makeNavigationController(image: UIImage?,
                                         title: String,
                                         rootViewController: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.tabBarItem.image = image
        navigationController.navigationBar.barTintColor = .white
        navigationController.title = title
        return navigationController
    }
}
