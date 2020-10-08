//
//  Photo.swift
//  VK Client
//
//  Created by Eugene Kiselev on 01.10.2020.
//  Copyright © 2020 Eugene Kiselev. All rights reserved.
//

import Foundation
import RealmSwift

class Photo: Object, Decodable {
    
    @objc dynamic var id = 0
    @objc dynamic var ownerId = 0
    var sizes = List<Sizes>()
}
