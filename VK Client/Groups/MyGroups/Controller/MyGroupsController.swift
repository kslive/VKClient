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
    var myGroups: Results<Group>!
    var token: NotificationToken?
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

        bindTableAndRealm()
        setupSearchController()
        fetchRequestGroupsUser()
    }
    

    @IBAction func addGroup(segue: UIStoryboardSegue) {
        
        if segue.identifier == "addGroup" {
        }
    }
    
    // MARK: Help Function
    
    private func fetchRequestGroupsUser() {
        
        do {
            let realm = try Realm()
            
            let groups = realm.objects(Group.self)
            
            myGroups = groups
        } catch {
            
            print(error)
        }
    }
    
    private func bindTableAndRealm() {
        
        guard let realm = try? Realm() else { return }
        
        myGroups = realm.objects(Group.self)
        
        token = myGroups.observe { [weak self] (changes: RealmCollectionChange) in
            
            guard let tableView = self?.tableView else { return }
            
            switch changes {
            case .initial:
                tableView.reloadData()
                
            case .update(_, let deletions, let insertions, let modifications):
                tableView.beginUpdates()
                tableView.insertRows(at: insertions.map({ IndexPath(row: $0,
                                                                    section: 0) }),
                                     with: .automatic)
                tableView.deleteRows(at: deletions.map({ IndexPath(row: $0,
                                                                   section: 0)}),
                                     with: .automatic)
                tableView.reloadRows(at: modifications.map({ IndexPath(row: $0,
                                                                       section: 0) }),
                                     with: .automatic)
                tableView.endUpdates()
                
            case .error(let error):
                fatalError("\(error)")
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
}
