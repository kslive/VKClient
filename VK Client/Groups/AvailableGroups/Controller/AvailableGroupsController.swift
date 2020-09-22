//
//  AvailableGroupsController.swift
//  VK Client
//
//  Created by Eugene Kiselev on 02.08.2020.
//  Copyright © 2020 Eugene Kiselev. All rights reserved.
//

import UIKit

class AvailableGroupsController: UITableViewController {
    
// Дефолтный массив:
    var allGroups = [Group(nameGroup: "New Rap News", imageGroup: "New Rap News"),
                     Group(nameGroup: "Лентач", imageGroup: "Лентач"),
                     Group(nameGroup: "Mac OS", imageGroup: "Mac OS"),
                     Group(nameGroup: "New Rap", imageGroup: "New Rap"),
                     Group(nameGroup: "Рифмы и Панчи", imageGroup: "Рифмы и Панчи"),
                     Group(nameGroup: "Hardcore Fighting", imageGroup: "Hardcore Fighting")]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allGroups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AvailableGroupsCell", for: indexPath) as! AvailableGroupsCell
        let allGroup = allGroups[indexPath.row]
        
        cell.configure(for: allGroup)
        
        return cell
    }
    
}
