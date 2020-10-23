//
//  AvailableGroupsController.swift
//  VK Client
//
//  Created by Eugene Kiselev on 02.08.2020.
//  Copyright © 2020 Eugene Kiselev. All rights reserved.
//

import UIKit

class AvailableGroupsController: UITableViewController {
    
    let searchController = UISearchController(searchResultsController: nil)
    let firebaseManager = FirebaseManager()
    let networkManager = NetworkManager()
    var allGroups = [Group]()
    var searchBarIsEmpty: Bool {
        
        guard let text = searchController.searchBar.text else { return false }
        
        return text.isEmpty
    }
    var isFiltering: Bool {
        
        return searchController.isActive && !searchBarIsEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchController()
    }
    
    // MARK: Help Function
    
    func fetchRequestSearchGroups(text: String?) {
        
        networkManager.fetchRequestSearchGroups(text: text) { [weak self] groups in
            
            DispatchQueue.main.async {
                
                if self!.isFiltering {
                    
                    self?.allGroups = groups
                }
                
                self?.tableView.reloadData()
            }
            
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFiltering {
            return allGroups.count
        }
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AvailableGroupsCell", for: indexPath) as! AvailableGroupsCell
        
        let allGroup = allGroups[indexPath.row]
        
        if isFiltering {
            
            cell.configure(for: allGroup)
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let indexPath = self.tableView.indexPathForSelectedRow {
            
            guard let userID = Session.shared.userId else { return }
            let group = allGroups[indexPath.row]
            
            firebaseManager.saveUserGroups(userID: userID, group: group)
        }
    }
}
