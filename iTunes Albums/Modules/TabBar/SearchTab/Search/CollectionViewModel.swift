//
//  CollectionViewModel.swift
//  iTunes Albums
//
//  Created by Андрей Останин on 27.12.2020.
//

import Foundation

class CollectionViewModel {
    
    // MARK: Properties
    private let networkManager = NetworkManager()
    private var galleryElements: [ItemViewModel] = []
    
    var count: Int {
        return galleryElements.count
    }

    // MARK: Network quieries
    func getElementVM(at index: Int) -> ItemViewModel? {
        if !galleryElements.isEmpty && galleryElements.count > index {
            return galleryElements[index]
        } else {
            return nil
        }
    }
    
    func fetchAlbums(for userQuery: String?, completion: @escaping () -> Void) {
        guard let q = userQuery else {
            return
        }
        
        clearCollection()
        networkManager.getSearchResult(term: q, limit: 200) { [weak self] (collection, err) in
            guard err == nil else {
                print(err!)
                return
            }
            
            collection?.forEach({ (item) in
                self?.galleryElements.append(ItemViewModel(item: item))
            })
            
            self?.galleryElements.sort(by: {$0.collectionName < $1.collectionName})
            completion()
            print(self?.count as Any)
        }
        
    }
    
    func fetchMainScreen(completion: @escaping () -> Void) {
        clearCollection()
        
        networkManager.getSearchResult(term: "клава кока", limit: 20) { [weak self] (collection, err) in
            collection?.forEach({ (item) in
                self?.galleryElements.append(ItemViewModel(item: item))
            })
            print(self?.count as Any)
            completion()
        }
    }
    
    // MARK: Collection managing methods
    private func clearCollection() {
        galleryElements = []
    }
    
    // MARK: DB methods
    func saveRecord(for query: String) {
        let date = Date()
        let id = UUID()
        DatabaseHelper.shared.saveRecord(for: query, date, id: id)
    }
}
