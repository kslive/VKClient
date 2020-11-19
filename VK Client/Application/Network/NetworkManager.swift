//
//  NetworkManager.swift
//  VK Client
//
//  Created by Eugene Kiselev on 26.09.2020.
//  Copyright © 2020 Eugene Kiselev. All rights reserved.
//

import Foundation
import PromiseKit

class NetworkManager {
    
    private var urlComponents = URLComponents()
    private let constants = NetworkConstants()
    private let configuration: URLSessionConfiguration!
    private let session: URLSession!
    private var realmManager = RealmManager()
    private let queue = OperationQueue()
    
    init() {
        
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
        
        return request
    }
    
    // MARK: Friends
    
    func fetchRequestFriends() -> Promise<[User]> {
        
        urlComponents.path = "/method/friends.get"
        
        urlComponents.queryItems = [
            URLQueryItem(name: "order", value: "name"),
            URLQueryItem(name: "fields", value: "sex, bdate, city, country, photo_100, photo_200_orig"),
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: constants.versionAPI)
        ]
        
        let promise = Promise<[User]> { [weak self] resolver in
            
            session.dataTask(with: urlComponents.url!) { (data, response, error) in
                
                guard let data = data else {
                    resolver.reject(error!)
                    return
                }
                
                do {
                    
                    let decoder = JSONDecoder()
                    
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    guard let friends = try decoder.decode(Response<User>.self, from: data).response?.items else {
                        resolver.reject(error!)
                        return
                    }
                    
                    resolver.fulfill(friends)
                    
                } catch {
                    resolver.reject(error)
                }
            }.resume()
        }
        
        
        return promise
    }
    // MARK: Photos User
    
    func fetchRequestPhotosUser(for ownerID: Int?, callback: @escaping () -> ()) {
        
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
        
        session.dataTask(with: urlComponents.url!) { [weak self] (data, response, error) in
            
            guard let data = data else { return }
            
            do {
                
                let decoder = JSONDecoder()
                
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                guard let photo = try decoder.decode(Response<Photo>.self, from: data).response?.items else { return }
                
                DispatchQueue.main.async {
                    
                    self?.realmManager.updatePhotos(for: photo)
                    callback()
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
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
        
        let getDataOperation = GetDataOperation(urlRequest: urlComponents.url!)
        queue.addOperation(getDataOperation)
       
        let parseDataOperation = ParseDataOperation<Group>()
        parseDataOperation.addDependency(getDataOperation)
        queue.addOperation(parseDataOperation)
        
        let savingDataOperation = SavingDataOperation<Group>()
        savingDataOperation.addDependency(parseDataOperation)
        queue.addOperation(savingDataOperation)
    }
    
    // MARK: Search Groups
    
    func fetchRequestSearchGroups(text: String?, completion: @escaping ([Group]) -> ()) {
        
        urlComponents.path = "/method/groups.search"
        
        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: text),
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: constants.versionAPI),
        ]
        
        session.dataTask(with: urlComponents.url!) { (data, response, error) in
            
            guard let data = data else { return }
            
            do {
                
                let decoder = JSONDecoder()
                
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                guard let searchGroups = try decoder.decode(Response<Group>.self, from: data).response?.items else { return }
                
                completion(searchGroups)
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    // MARK: - News
    
    func fetchRequestNews(completion: @escaping ([NewsModel]) -> Void) {
        urlComponents.path = "/method/newsfeed.get"
        
        urlComponents.queryItems = [
            URLQueryItem(name: "filters", value: "post"),
            URLQueryItem(name: "count", value: "100"),
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: constants.versionAPI)
        ]
        
        
        let task = session.dataTask(with: urlComponents.url!) { (data, response, error) in
            
            guard let data = data else { return }
            
            let decoder = JSONDecoder()
            
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            guard var news = try? decoder.decode(Response<NewsModel>.self, from: data).response?.items else { return }
            guard let profiles = try? decoder.decode(ResponseNews.self, from: data).response.profiles else { return }
            guard let groups = try? decoder.decode(ResponseNews.self, from: data).response.groups else { return }
            
            for i in 0..<news.count {
                if news[i].sourceId < 0 {
                    let group = groups.first(where: { $0.id == -news[i].sourceId })
                    news[i].avatarUrl = group?.photo100
                    news[i].creatorName = group?.name
                } else {
                    let profile = profiles.first(where: { $0.id == news[i].sourceId })
                    news[i].avatarUrl = profile?.photo100
                    news[i].creatorName = profile?.firstName
                }
            }
            
            DispatchQueue.main.async {
                completion(news)
            }
        }
        
        DispatchQueue.global(qos: .utility).async {
            task.resume()
        }
        
    }
}
