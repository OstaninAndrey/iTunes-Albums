//
//  ItemViewModel.swift
//  iTunes Albums
//
//  Created by Андрей Останин on 27.12.2020.
//

import Foundation
import UIKit

class ItemViewModel {
    
    // MARK: Properties
    private var item: MediaEntity
    private let networkManager = NetworkManager()
    
    var wrapperType: String {
        return item.wrapperType
    }
    
    private var id: Int {
        return item.collectionId
    }
    
    private var artworkUrl100: String {
        item.artworkUrl100
    }
    
    var artistName: String {
        return item.artistName
    }
    
    var collectionName: String {
        return item.collectionName
    }
    
    var trackName: String? {
        item.trackCensoredName
    }
    
    var trackNumber: Int? {
        item.trackNumber
    }
    
    
    var collectionId: Int {
        item.collectionId
    }
    
    // MARK: Init
    init(item: MediaEntity) {
        self.item = item
    }
    
    // MARK: Network methods
    func loadImage(completion: @escaping (UIImage?) -> Void) {
        
        networkManager.loadImage(stringUrl: artworkUrl100) { (image, error) in
            guard error == nil else {
                print(error as Any)
                
                completion(nil)
                return
            }
            completion(image)
        }
        
    }
    
}
