//
//  Constants.swift
//  iTunes Albums
//
//  Created by Андрей Останин on 27.12.2020.
//

import UIKit

public struct K {
    
    struct Path {
        static let basePath = "https://itunes.apple.com/"
        static let search = "search"
        static let lookup = "lookup"
        static let empty = ""
    }
    
    struct QueryContentType {
        static let contentType = "Content-Type"
        static let json = "application/json"
        static let encodedUTF8 = "application/x-www-form-urlencoded; charset=utf-8"
    }
    
    struct ParameterOptions {
        static let term = "term"
        static let entity = "entity"
        static let limit = "limit"
        static let id = "id" 
    }
    
    struct MediaType {
        static let song = "song"
        static let album = "album"
    }
    
    struct Cell {
        struct ThumbCell {
            static let nibName = "ThumbCell"
            static let reuseID = "ThumbCell"
        }
        
        struct SongNameCell {
            static let nibName = "SongNameCell"
            static let reuseID = "SongNameCell"
        }
        
        struct SavedCell {
            static let nibName = "SavedTableViewCell"
            static let reuseID = "SavedTableViewCell"
        }
        
        struct AlbumFaceCell {
            static let nibName = "AlbumFaceCell"
            static let reuseID = "AlbumFaceCell"
        }
    }
    
    struct TabBar {
        static let mainTabName = "iTunes Search"
        static let historyTabName = "History"
    }
    
    struct Image {
        static let history = "HistoryIcon"
        static let search = "SearchIcon"
    }
    
    struct FontSize {
        static let small: CGFloat = 15
        static let medium: CGFloat = 18
        static let large: CGFloat = 20
    }
    
    static let backgroundColor = "BackgroundColor"
    
    struct WrapperType {
        static let collection = "collection"
        static let track = "track"
    }
    
    struct EntityName {
        static let searchRecord = "SearchRecord"
    }
}
