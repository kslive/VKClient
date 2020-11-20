//
//  NewsViewController.swift
//  VK Client
//
//  Created by Eugene Kiselev on 31.08.2020.
//  Copyright © 2020 Eugene Kiselev. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {
    
    private let refreshControl = UIRefreshControl()
    private let networkManager = NetworkManager()
    
    var news = [NewsModel]()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchRequestNews()
        setupRefreshControl()
    }
    
    func setupRefreshControl() {
        
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(reload), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    func fetchRequestNews(callback: (([NewsModel]) -> ())? = nil) {
        
        networkManager.fetchRequestNews { news in
            
            self.news = news
            
            callback?(news)
            
            OperationQueue.main.addOperation { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
}

extension NewsViewController {
    
    @objc private func reload() {
        
        fetchRequestNews { [weak self] news in
            guard let self = self else { return }
            
            self.refreshControl.endRefreshing()
            
            guard news.count > 0 else { return }
            self.news = news + self.news
        }
    }
}

extension NewsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
        
        let newsItem = news[indexPath.row]
        
        cell.configure(for: newsItem)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
