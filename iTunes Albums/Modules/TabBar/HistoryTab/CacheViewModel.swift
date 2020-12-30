//
//  CacheViewModel.swift
//  iTunes Albums
//
//  Created by Андрей Останин on 27.12.2020.
//

import Foundation

class CacheViewModel {
    // MARK: Properties
    private var records: [SearchRecord] = []
    
    var count: Int {
        records.count
    }
    
    // MARK: Chache managing methods
    func getRecordInstance(index: Int) -> SearchRecord? {
        if !records.isEmpty, records.count >= index {
            return records[index]
        } else {
            return nil
        }
    }
    
    func loadRecords(completion: () -> Void) {
        records = DatabaseHelper.shared.getAllRecords()
        records.sort(by: {$0.date! > $1.date!})
        completion()
    }
    
    func removeRecord(at index: Int) -> Bool {
        if DatabaseHelper.shared.remove(id: records[index].id ?? UUID()) {
            records.remove(at: index)
    
            return true
        }
    
        return false
    }
    
}
