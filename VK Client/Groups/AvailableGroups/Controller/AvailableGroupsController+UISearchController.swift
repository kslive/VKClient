//
//  AvailableGroupsController+UISearchController.swift
//  VK Client
//
//  Created by Eugene Kiselev on 01.10.2020.
//  Copyright © 2020 Eugene Kiselev. All rights reserved.
//

import UIKit

// sorry for that @Leonid
extension AvailableGroupsController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func setupSearchController() {
    
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Groups"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
    
    func filterContentForSearchText(_ searchText: String) {
        
        fetchRequestSearchGroups(text: searchText)
        allGroups = allGroups.filter{ (group: Group) -> Bool in

            guard let name = group.name else { return false }
            return name.contains(searchText)
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        allGroups.removeAll()
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        allGroups.removeAll()
        tableView.reloadData()
    }
}
