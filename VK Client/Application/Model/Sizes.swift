//
//  Sizes.swift
//  VK Client
//
//  Created by Eugene Kiselev on 01.10.2020.
//  Copyright © 2020 Eugene Kiselev. All rights reserved.
//

import Foundation
import RealmSwift

class Sizes: Object, Decodable {
    
    @objc dynamic var type: String? = nil
    @objc dynamic var src: String? = nil
}
