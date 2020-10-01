//
//  Items.swift
//  VK Client
//
//  Created by Eugene Kiselev on 01.10.2020.
//  Copyright © 2020 Eugene Kiselev. All rights reserved.
//

import Foundation

class Items<T: Decodable>: Decodable {
    
    let items: [T]?
}
