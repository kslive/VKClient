//
//  NetworkManager.swift
//  VK Client
//
//  Created by Eugene Kiselev on 26.09.2020.
//  Copyright © 2020 Eugene Kiselev. All rights reserved.
//

import Foundation

class NetworkManager {
    
    static var shared = NetworkManager()
    
    private var urlComponents = URLComponents()
    private let constants = NetworkConstants()
    private let configuration: URLSessionConfiguration!
    private let session: URLSession!
    
    private init() {
        
        urlComponents.scheme = constants.scheme
        urlComponents.host = constants.host
        configuration = URLSessionConfiguration.default
        session = URLSession(configuration: configuration)
    }
    
    // MARK: Authorization
    
    func fetchRequestAuthorization() -> URLRequest? {
        
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: constants.clientID),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: constants.scope),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: constants.versionAPI)
        ]
        
        guard let url = urlComponents.url else { return nil }
        let request = URLRequest(url: url)
        
        fetchRequestFriends()
        return request
    }
    
    // MARK: Friends
    
    func fetchRequestFriends() {
        
        urlComponents.path = "/method/friends.get"
        
        urlComponents.queryItems = [
            URLQueryItem(name: "order", value: "name"),
            URLQueryItem(name: "fields", value: "sex, bdate, city, country, photo_100, photo_200_orig"),
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: constants.versionAPI)
        ]
        
        let task = session.dataTask(with: urlComponents.url!) { (data, response, error) in
            
            guard let data = data else { return }
            
            do {
                
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                
                print(json)
            } catch {
                print(error.localizedDescription)
            }
        }
        
        task.resume()
    }
    // MARK: Photos User
    
    func fetchRequestPhotosUser(for ownerID: Int?) {
        
        urlComponents.path = "/method/photos.getAll"
        
        guard let ownerID = ownerID else { return }
        urlComponents.queryItems = [
            URLQueryItem(name: "owner_id", value: String(ownerID)),
            URLQueryItem(name: "photo_sizes", value: "1"),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "count", value: "20"),
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: constants.versionAPI)
        ]
        
        let task = session.dataTask(with: urlComponents.url!) { (data, response, error) in
            
            guard let data = data else { return }
            
            do {
                
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                
                print(json)
            } catch {
                print(error.localizedDescription)
            }
        }
        
        task.resume()
    }
    // MARK: Groups User
    
    func fetchRequestGroupsUser() {
        
        urlComponents.path = "/method/groups.get"
        
        urlComponents.queryItems = [
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "fields", value: "description"),
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: constants.versionAPI)
        ]
        
        let task = session.dataTask(with: urlComponents.url!) { (data, response, error) in
            
            guard let data = data else { return }
            
            do {
                
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                
                print(json)
            } catch {
                print(error.localizedDescription)
            }
        }
        
        task.resume()
    }
    
    // MARK: Search Groups
    
    func fetchRequestSearchGroups(text: String?) {
        
        urlComponents.path = "/method/groups.search"
        
        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: text),
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: constants.versionAPI),
        ]
        
        let task = session.dataTask(with: urlComponents.url!) { (data, response, error) in
            
            guard let data = data else { return }
            
            do {
                
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                
                print(json)
            } catch {
                print(error.localizedDescription)
            }
        }
        
        task.resume()
    }
}
