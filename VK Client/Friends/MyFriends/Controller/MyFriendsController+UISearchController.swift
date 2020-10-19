//
//  MyFriendsController+UISearchController.swift
//  VK Client
//
//  Created by Eugene Kiselev on 31.08.2020.
//  Copyright © 2020 Eugene Kiselev. All rights reserved.
//

import UIKit

extension MyFriendsController: UISearchResultsUpdating {
    
    
    func setupSearchController() {
    
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Friends"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
        
    }
    
    func filterContentForSearchText(_ searchText: String) {
        
        filteredUsers = friends.filter{ (user: User) -> Bool in
        
            guard let name = user.firstName,
                  let lastName = user.lastName else { return false }
            let fullName = name + " " + lastName
            
            return fullName.contains(searchText)
        }
        
        tableView.reloadData()
    }
}
