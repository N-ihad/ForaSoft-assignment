//
//  Utilities.swift
//  ForaSoft-assignment
//
//  Created by Nihad on 1/14/21.
//

import Foundation
import SwiftyJSON

struct Utilities {
    func txtJSONToSwiftAlbumObjects(txtData: Data) -> [Album] {
        let jsonData = JSON.init(parseJSON: String(decoding: txtData, as: UTF8.self))
        let albums = jsonData.dictionaryValue["results"] ?? []
        var swiftAlbums = [Album]()
        for album in albums.array ?? [] {
            swiftAlbums.append(Album(artistID: album.dictionary?["artistId"]?.int ?? 0,
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
                                      primaryGenreName: album.dictionary?["primaryGenreName"]?.string ?? ""))
        }
        
        return swiftAlbums
    }
}
