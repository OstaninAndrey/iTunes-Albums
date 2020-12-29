//
//  DatabaseHelper.swift
//  iTunes Albums
//
//  Created by Андрей Останин on 27.12.2020.
//

import Foundation
import CoreData
import UIKit

class DatabaseHelper {
    // MARK: Properties
    static let shared = DatabaseHelper()
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // MARK: DB records managing - CRUD
    func saveRecord(for query: String, _ date: Date, id: UUID) {
        
        let record = NSEntityDescription.insertNewObject(forEntityName: K.EntityName.searchRecord, into: context) as! SearchRecord
        record.query = query
        record.date = date
        record.id = id

        do{
            try context.save()
            print("Record succesfully saved")
        } catch let err {
            print(err.localizedDescription)
        }
        
        
    }
    
    func getAllRecords() -> [SearchRecord] {
        var arr: [SearchRecord] = []

        let request = NSFetchRequest<NSFetchRequestResult>(entityName: K.EntityName.searchRecord)
        do {
            arr = try context.fetch(request) as! [SearchRecord]
        } catch {
            print(error)
        }

        return arr
    }
    
    func remove(id: UUID) -> Bool{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: K.EntityName.searchRecord)

        fetchRequest.predicate = NSPredicate(format: "id = %@", "\(id)")

        do {
            let test = try context.fetch(fetchRequest)
            let objToDelete = test.first as! NSManagedObject
            context.delete(objToDelete)

            do {
                try context.save()
                print("Record successfully removed")
            } catch {
                print("Unable To Save Updates")
                return false
            }

        } catch {
            print("Unable To Delete")
            return false
        }

        return true
    }
    
}
