//
//  Group.swift
//  VK Client
//
//  Created by Eugene Kiselev on 02.08.2020.
//  Copyright © 2020 Eugene Kiselev. All rights reserved.
//

import Foundation
import RealmSwift

class Group: Object, Decodable {
    
    @objc dynamic var id = 0
    @objc dynamic var name: String?
    @objc dynamic var photo50: String?
}
