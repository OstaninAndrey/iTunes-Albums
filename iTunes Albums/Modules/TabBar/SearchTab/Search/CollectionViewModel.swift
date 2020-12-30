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
    private var itemCollection: [ItemViewModel] = []
    
    var count: Int {
        return itemCollection.count
    }

    // MARK: Network quieries
    func getItemViewModel(at index: Int) -> ItemViewModel? {
        if !itemCollection.isEmpty && itemCollection.count > index {
            return itemCollection[index]
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
                self?.itemCollection.append(ItemViewModel(item: item))
            })
            
            self?.itemCollection.sort(by: {$0.collectionName < $1.collectionName})
            completion()
            print(self?.count as Any)
        }
        
    }
    
    func fetchMainScreen(completion: @escaping () -> Void) {
        clearCollection()
        
        networkManager.getSearchResult(term: "клава кока", limit: 20) { [weak self] (collection, err) in
            collection?.forEach({ (item) in
                self?.itemCollection.append(ItemViewModel(item: item))
            })
            print(self?.count as Any)
            completion()
        }
    }
    
    // MARK: Collection managing methods
    private func clearCollection() {
        itemCollection = []
    }
    
    // MARK: DB methods
    func saveRecord(for query: String) {
        let date = Date()
        let id = UUID()
        DatabaseHelper.shared.saveRecord(for: query, date, id: id)
    }
}
