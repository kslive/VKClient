//
//  MyGroupsController+UISearchController.swift
//  VK Client
//
//  Created by Eugene Kiselev on 31.08.2020.
//  Copyright © 2020 Eugene Kiselev. All rights reserved.
//

import UIKit

extension MyGroupsController: UISearchResultsUpdating {
    
    
    func setupSearchController() {
    
// Получаем инфо об изменении текста:
        searchController.searchResultsUpdater = self
// Запрет взаимодействия с контентом при вводе:
        searchController.obscuresBackgroundDuringPresentation = false
// Название строки поиска:
        searchController.searchBar.placeholder = "Search Groups"
// Расположение:
        navigationItem.searchController = searchController
// Строка поиска при переходе:
        definesPresentationContext = true
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
    
    func filterContentForSearchText(_ searchText: String) {
        
        filteredGroups = myGroups.filter{ (group: Group) -> Bool in
            
            guard let name = group.name else { return false }
            return name.contains(searchText)
        }
        
        tableView.reloadData()
    }
}
