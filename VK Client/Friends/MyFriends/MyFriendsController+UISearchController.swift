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
    
// Получаем инфо об изменении текста:
        searchController.searchResultsUpdater = self
// Запрет взаимодействия с контентом при вводе:
        searchController.obscuresBackgroundDuringPresentation = false
// Название строки поиска:
        searchController.searchBar.placeholder = "Search Friends"
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
        
        filteredUsers = friends.filter{ (user: User) -> Bool in
            return user.nameSurnameFriend.contains(searchText)
        }
        
        tableView.reloadData()
    }
}
