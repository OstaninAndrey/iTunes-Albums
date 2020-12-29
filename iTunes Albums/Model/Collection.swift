//
//  Collection.swift
//  iTunes Albums
//
//  Created by Андрей Останин on 27.12.2020.
//

import Foundation

struct Collection: Decodable {
    let resultCount: Int
    let results: [MediaEntity]
}

struct MediaEntity: Decodable {
    let wrapperType: String
    let collectionId: Int
    let artistName: String
    let collectionName: String
    let artworkUrl100: String
    let trackName: String?
    let trackNumber: Int?
    let trackCensoredName: String?
}
