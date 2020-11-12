//
//  SavingDataOperation.swift
//  VK Client
//
//  Created by Eugene Kiselev on 12.11.2020.
//  Copyright © 2020 Eugene Kiselev. All rights reserved.
//

import Foundation
import RealmSwift

class SavingDataOperation<T: Object & Codable>: Operation {
    
    override func main() {
        guard let parseDataOperation = dependencies.first as? ParseDataOperation<T>,
              let outputData = parseDataOperation.outputData else { return }
        
        do {
            let realm = try Realm()
            let oldValues = realm.objects(T.self)
            realm.beginWrite()
            realm.delete(oldValues)
            realm.add(outputData)
            try realm.commitWrite()
            
            print("Completed Saving")
        } catch {
            print(error)
        }
    }
}
