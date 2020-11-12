//
//  ParseDataOperation.swift
//  VK Client
//
//  Created by Eugene Kiselev on 12.11.2020.
//  Copyright © 2020 Eugene Kiselev. All rights reserved.
//

import Foundation

class ParseDataOperation<T:Codable>: Operation {
    
    var outputData: [T]?
    
    override func main() {
        guard let getDataOperation = dependencies.first as? GetDataOperation,
              let data = getDataOperation.data else { return }
        
        let decoder = JSONDecoder()
        
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        guard let dataParsed = try? decoder.decode(Response<T>.self, from: data).response?.items else { return }
        outputData = dataParsed
    }
}
