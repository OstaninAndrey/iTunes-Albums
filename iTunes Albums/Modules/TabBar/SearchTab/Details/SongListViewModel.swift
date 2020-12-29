//
//  DetailsViewModel.swift
//  iTunes Albums
//
//  Created by Андрей Останин on 29.12.2020.
//

import Foundation

class SongListViewModel {
    
    // MARK: Properties
    private let albumId: Int
    private let networkManager = NetworkManager()
    private var songs: [ItemViewModel] = []
    
    var count: Int {
        return songs.count
    }
    
    // MARK: Init
    init(albumId: Int) {
        self.albumId = albumId
    }
    
    // MARK: Network managing methods
    func fetchSongList(completion: @escaping () -> Void) {
        networkManager.getSongsList(from: albumId) { [weak self] (list, err) in
            guard err == nil else {
                print(err!)
                return
            }
            
            list?.forEach({ (item) in
                self?.songs.append(ItemViewModel(item: item))
            })
            
            completion()
            print(self?.count as Any)
        }
    }
    
    // MARK: Data access methods
    func getItem(at index: Int) -> ItemViewModel? {
        if !songs.isEmpty && songs.count > index {
            return songs[index]
        } else {
            return nil
        }
    }

}
