//
//  MyFriendsController.swift
//  VK Client
//
//  Created by Eugene Kiselev on 02.08.2020.
//  Copyright © 2020 Eugene Kiselev. All rights reserved.
//

import UIKit
import RealmSwift

class MyFriendsController: UITableViewController {
    
    let searchController = UISearchController(searchResultsController: nil)
    var friends: Results<User>!
    var filteredUsers = [User]()
    var token: NotificationToken?
    var searchBarIsEmpty: Bool {
        
        guard let text = searchController.searchBar.text else { return false }
        
        return text.isEmpty
    }
    var isFiltering: Bool {
        
        return searchController.isActive && !searchBarIsEmpty
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchRequestFriends()
        setupSearchController()
        tableView.sectionIndexColor = .white
        bindTableAndRealm()
    }
    
    // MARK: - Help Function
    
    private func fetchRequestFriends() {
        
        do {
            let realm = try Realm()
            
            let friend = realm.objects(User.self)
            
            friends = friend
        } catch {
            
            print(error)
        }
    }
    
    private func bindTableAndRealm() {
        
        guard let realm = try? Realm() else { return }
        
        friends = realm.objects(User.self)
        
        token = friends.observe { [weak self] (changes: RealmCollectionChange) in
            
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
            return filteredUsers.count
        }

        return friends.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyFriendsCell", for: indexPath) as! MyFriendsCell
        let myFriend: User
        
        if isFiltering {
            myFriend = filteredUsers[indexPath.row]
        } else {
            myFriend = friends[indexPath.row]
        }
        
        cell.configure(for: myFriend)
        
        return cell
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "addImage" {
            
            let detailFriendController = segue.destination as? DetailFriendController
            if let indexPath = self.tableView.indexPathForSelectedRow {
                
                if isFiltering {

                    let friends = filteredUsers[indexPath.row]
                    
                    guard let name = friends.firstName,
                          let lastName = friends.lastName else { return }
                        
                    detailFriendController?.fetchRequestPhotosUser(for: friends.id)
                    detailFriendController?.titleItem = name + " " + lastName
                    detailFriendController?.ownerID = friends.id
                } else {
                    
                    let friend = friends[indexPath.row]
                    
                    guard let name = friend.firstName,
                          let lastName = friend.lastName else { return }
                    
                    detailFriendController?.fetchRequestPhotosUser(for: friend.id)
                    detailFriendController?.titleItem = name + " " + lastName
                    detailFriendController?.ownerID = friend.id
                    
                }
            }
        }
    }
}
