//
//  Album.swift
//  ForaSoft-assignment
//
//  Created by Nihad on 1/13/21.
//

import Foundation

struct Album {

    let artistID, collectionID: Int
    let artistName: String
    let collectionName: String
    let collectionViewURL: String
    let artworkURL: String
    let collectionPrice: Double
    let collectionExplicitness: String
    let trackCount: Int
    let country: String
    let releaseDate: String
    let primaryGenreName: String

    var detailsDescription: [(String, String)] {
        get {
            return [
                ("Artist", artistName),
                ("Artwork URL", collectionViewURL),
                ("Price $", String(collectionPrice)),
                ("Explicit", collectionExplicitness),
                ("Country", country),
                ("Release year", releaseDate),
                ("Genre", primaryGenreName)
            ]
        }
    }

    static func removeDuplicateAlbums(_ albums: [Album]) -> [Album] {
        var uniqueAlbums = [Album]()
        for album in albums where !uniqueAlbums.contains(where: { $0.collectionName == album.collectionName })  {
            uniqueAlbums.append(album)
        }
        return uniqueAlbums
    }
}
