//
//  Session.swift
//  VK Client
//
//  Created by Eugene Kiselev on 22.09.2020.
//  Copyright © 2020 Eugene Kiselev. All rights reserved.
//

import Foundation

class Session {
    
    static let shared = Session()
    
    var token: String?
    var userId: Int?
    
    private init(){}
}
