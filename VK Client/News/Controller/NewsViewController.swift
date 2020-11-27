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
    private var nextFrom = ""
    private var isLoading = false
    
    var news = [NewsModel]()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.prefetchDataSource = self
        
        fetchRequestNews()
        setupRefreshControl()
    }
    
    func setupRefreshControl() {
        
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(reload), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    func fetchRequestNews(nextFrom: String = "" ,callback: (([NewsModel], String?) -> ())? = nil) {
        
        networkManager.fetchRequestNews(startFrom: nextFrom) { [weak self] (news, nextFrom) in
            
            self?.nextFrom = nextFrom
            self?.news = news
            
            callback?(news,nextFrom)
            
            OperationQueue.main.addOperation {
                self?.tableView.reloadData()
            }
        }
    }
}

// MARK: ACTION

extension NewsViewController {
    
    @objc private func reload() {
        
        fetchRequestNews { [weak self] (news,_) in
            guard let self = self else { return }
            
            self.refreshControl.endRefreshing()
            
            guard news.count > 0 else { return }
            self.news = news + self.news
        }
    }
}

// MARK: TABLE VIEW DATA SOURCE

extension NewsViewController: UITableViewDataSource {
    
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

// MARK: PREFETCHING
 
extension NewsViewController: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
        guard let maxRow = indexPaths
                .map({ $0.row })
                .max()
        else { return }
        
        if maxRow > news.count - 3,
           !isLoading {
            isLoading = true
            
            fetchRequestNews(nextFrom: nextFrom) { [weak self] (news,_) in
                guard let self = self else { return }
                
                self.news.append(contentsOf: news)                
                self.isLoading = false
            }
        }
    }
}
