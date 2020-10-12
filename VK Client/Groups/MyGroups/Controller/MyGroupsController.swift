//
//  MyGroupsController.swift
//  VK Client
//
//  Created by Eugene Kiselev on 02.08.2020.
//  Copyright © 2020 Eugene Kiselev. All rights reserved.
//

import UIKit
import RealmSwift

class MyGroupsController: UITableViewController {
    
    let searchController = UISearchController(searchResultsController: nil)
    let realmManager = RealmManager()
    var myGroups = [Group]()
    var filteredGroups = [Group]()
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
        fetchRequestGroupsUser()
    }
    

    @IBAction func addGroup(segue: UIStoryboardSegue) {
        
        if segue.identifier == "addGroup" {
            guard let availableGroups = segue.source as? AvailableGroupsController else { return }
            if let indexPath = availableGroups.tableView.indexPathForSelectedRow {
                let group = availableGroups.allGroups[indexPath.row]

                if !myGroups.contains(where: {$0.id == group.id}) {
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
    
    // MARK: Help Function
    
    func fetchRequestGroupsUser() {
        
        do {
            let realm = try Realm()
            
            let groups = realm.objects(Group.self)
            
            myGroups = Array(groups)
        } catch {
            
            print(error)
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
}
