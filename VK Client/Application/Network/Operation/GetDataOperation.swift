//
//  GetDataOperation.swift
//  VK Client
//
//  Created by Eugene Kiselev on 12.11.2020.
//  Copyright © 2020 Eugene Kiselev. All rights reserved.
//

import Foundation

class GetDataOperation: AsyncOperation {
    
    private var urlConstructor = URLComponents()
    private let configuration: URLSessionConfiguration!
    private let session: URLSession!
    private let constants = NetworkConstants()
    private var urlRequest: URL
    private var task: URLSessionTask?
    
    var data: Data?
    
    override func cancel() {
        task?.cancel()
        super.cancel()
    }
    
    override func main() {
        task = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            guard error == nil,
                  let data = data else { return }
            self.data = data
            self.state = .finished
        })
        task?.resume()
    }
    
    init(urlRequest: URL) {
        urlConstructor.scheme = constants.scheme
        urlConstructor.host = constants.host
        configuration = URLSessionConfiguration.default
        session = URLSession(configuration: configuration)
        
        self.urlRequest = urlRequest
    }
    
}
