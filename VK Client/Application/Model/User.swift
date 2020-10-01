//
//  User.swift
//  VK Client
//
//  Created by Eugene Kiselev on 02.08.2020.
//  Copyright © 2020 Eugene Kiselev. All rights reserved.
//

import Foundation

class User: Decodable {
    
    let id: Int?
    let firstName: String?
    let lastName: String?
    let photo100: String?
}

