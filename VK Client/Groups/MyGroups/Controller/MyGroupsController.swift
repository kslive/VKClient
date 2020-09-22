//
//  MyGroupsController.swift
//  VK Client
//
//  Created by Eugene Kiselev on 02.08.2020.
//  Copyright © 2020 Eugene Kiselev. All rights reserved.
//

import UIKit

class MyGroupsController: UITableViewController {
    
// Объявляем экземпляр класса:
    let searchController = UISearchController(searchResultsController: nil)
// Массив:
    var filteredGroups = [Group]()
// Свойство определяющее является ли строка пустой или нет:
    var searchBarIsEmpty: Bool {
        
        guard let text = searchController.searchBar.text else { return false }
        
        return text.isEmpty
    }
// Логическое свойство, которое будет возвращать true в том случае, когда поисковой запрос был активирован:
    var isFiltering: Bool {
        
        return searchController.isActive && !searchBarIsEmpty
    }
    var myGroups = [Group]()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSearchController()
    }

    @IBAction func addGroup(segue: UIStoryboardSegue) {
        
        if segue.identifier == "addGroup" {
            guard let availableGroups = segue.source as? AvailableGroupsController else { return }
            if let indexPath = availableGroups.tableView.indexPathForSelectedRow {
                let group = availableGroups.allGroups[indexPath.row]
                
                if !myGroups.contains(where: {$0.nameGroup == group.nameGroup}) {
                    myGroups.append(group)
                    tableView.reloadData()
                } else {
                    
                    let alert = UIAlertController(title: "Choose another group",
                                                  message: "This group already exists on your list",
                                                  preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "OK", style: .cancel)
                    alert.addAction(alertAction)
                    present(alert, animated: true)
                }
            }
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFiltering {
            return filteredGroups.count
        }
        
        return myGroups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyGroupsCell", for: indexPath) as! MyGroupsCell
        let myGroup: Group
        
        if isFiltering {
            myGroup = filteredGroups[indexPath.row]
        } else {
            myGroup = myGroups[indexPath.row]
        }
        
        cell.configure(for: myGroup)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            if isFiltering {
                
                let filteredGroup = filteredGroups.remove(at: indexPath.row)
                myGroups.removeAll(where: {$0.nameGroup == filteredGroup.nameGroup})
            } else {
                
                myGroups.remove(at: indexPath.row)
            }
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
