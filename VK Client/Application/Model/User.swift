//
//  User.swift
//  VK Client
//
//  Created by Eugene Kiselev on 02.08.2020.
//  Copyright © 2020 Eugene Kiselev. All rights reserved.
//

import Foundation
import RealmSwift

class User: Decodable {
    
    @objc dynamic var id = 0
    @objc dynamic var firstName: String?
    @objc dynamic var lastName: String?
    @objc dynamic var photo100: String?
    
    func returnFullName() -> String? {
        
        return "\(firstName ?? "") \(lastName ?? "")"
    }
}

