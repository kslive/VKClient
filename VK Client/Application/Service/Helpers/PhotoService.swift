//
//  PhotoService.swift
//  VK Client
//
//  Created by Eugene Kiselev on 19.11.2020.
//  Copyright © 2020 Eugene Kiselev. All rights reserved.
//

import UIKit

private protocol DataReloadable {
    func reloadRow(at indexPath: IndexPath)
}

class PhotoService {
    
    private let cacheLifeTime: TimeInterval = 30 * 24 * 60 * 60
    private let container: DataReloadable
    private var images = [String: UIImage]()
    private static let pathName: String = {
        
        let pathName = "images"
        
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return pathName }
        let url = cachesDirectory.appendingPathComponent(pathName, isDirectory: true)
        
        if !FileManager.default.fileExists(atPath: url.path) {
            try? FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        }
        
        return pathName
    }()
    
    init(container: UITableView) {
        self.container = Table(table: container)
    }
    
    init(container: UICollectionView) {
        self.container = Collection(collection: container)
    }
    
    private func getFilePath(url: String) -> String? {
        
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil }
        
        let hashName = url.split(separator: "/").last ?? "default"
        return cachesDirectory.appendingPathComponent(PhotoService.pathName + "/" + hashName).path
    }
    
    private func saveImageToCache(url: String, image: UIImage) {
        guard let fileName = getFilePath(url: url),
              let data = image.pngData() else { return }
        
        FileManager.default.createFile(atPath: fileName, contents: data, attributes: nil)
    }
    
    private func getImageFromCache(url: String) -> UIImage? {
        guard let fileName = getFilePath(url: url),
              let info = try? FileManager.default.attributesOfItem(atPath: fileName),
              let modificationDate = info[FileAttributeKey.modificationDate] as? Date
        else { return nil }
        
        let lifeTime = Date().timeIntervalSince(modificationDate)
        
        guard lifeTime <= cacheLifeTime,
              let image = UIImage(contentsOfFile: fileName) else { return nil }
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.images[url] = image
        }
        
        return image
    }
    
    private func loadPhoto(at indexPath: IndexPath, by url: String) {
        
        guard let urlRequest = URL(string: url) else { return }
        let request = URLRequest(url: urlRequest)
        
        URLSession.shared.dataTask(with: request) { (data, response, _ ) in
            guard
                let data = data,
                let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async { [unowned self] in
                self.images[url] = image
            }
            
            self.saveImageToCache(url: url, image: image)
            
            DispatchQueue.main.async { [unowned self] in
                self.container.reloadRow(at: indexPath)
            }
        }.resume()
    }
    
    func photo(at indexPath: IndexPath, by url: String) -> UIImage? {
        var image: UIImage?
        if let photo = images[url] {
            image = photo
        } else
        
        if let photo = getImageFromCache(url: url) {
            image = photo
        } else {
            loadPhoto(at: indexPath, by: url)
        }
        return image
    }
}

extension PhotoService {
    
    private class Table: DataReloadable {
        let table: UITableView
        
        init(table: UITableView) {
            self.table = table
        }
        
        func reloadRow(at indexPath: IndexPath) {
            table.reloadRows(at: [indexPath], with: .none)
        }
    }
    
    private class Collection: DataReloadable {
        let collection: UICollectionView
        
        init(collection: UICollectionView) {
            self.collection = collection
        }
        
        func reloadRow(at indexPath: IndexPath) {
            collection.reloadItems(at: [indexPath])
        }
    }
}
