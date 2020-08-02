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
    var allGroups = [Group(nameGroup: "New Rap News", imageGroup: #imageLiteral(resourceName: "55")),
                     Group(nameGroup: "Лентач", imageGroup: #imageLiteral(resourceName: "11")),
                     Group(nameGroup: "Mac OS", imageGroup: #imageLiteral(resourceName: "33")),
                     Group(nameGroup: "New Rap", imageGroup: #imageLiteral(resourceName: "44")),
                     Group(nameGroup: "Рифмы и Панчи", imageGroup: #imageLiteral(resourceName: "66")),
                     Group(nameGroup: "Hardcore Fighting", imageGroup: #imageLiteral(resourceName: "22"))]

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
        
        cell.groupNameLabel.text = allGroup.nameGroup
        cell.groupImage.image = allGroup.imageGroup
        
        return cell
    }
    
}
