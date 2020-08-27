//
//  MyGroupsController.swift
//  VK Client
//
//  Created by Eugene Kiselev on 02.08.2020.
//  Copyright © 2020 Eugene Kiselev. All rights reserved.
//

import UIKit

class MyGroupsController: UITableViewController {
    
    var myGroups = [Group]()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myGroups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyGroupsCell", for: indexPath) as! MyGroupsCell
        let myGroup = myGroups[indexPath.row]
        
        cell.configure(for: myGroup)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {
            myGroups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
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
}
