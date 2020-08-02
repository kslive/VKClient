//
//  MyGroupsController.swift
//  VK Client
//
//  Created by Eugene Kiselev on 02.08.2020.
//  Copyright © 2020 Eugene Kiselev. All rights reserved.
//

import UIKit

class MyGroupsController: UITableViewController {
    
// Дефолтный массив:
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
        
        cell.myGroupNameLabel.text = myGroup.nameGroup
        cell.myGroupImage.image = myGroup.imageGroup
        
        return cell
    }
    
// Удаление ячеек:
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

// Если была нажата кнопка удалить:
        if editingStyle == .delete {
// Удаляем из массива:
            myGroups.remove(at: indexPath.row)
// Удаляем строку из таблицы:
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    @IBAction func addGroup(segue: UIStoryboardSegue) {
        
// Проверяем идентификатор:
        if segue.identifier == "addGroup" {
// Ссылка на контроллер, с которого происходит переход:
            guard let availableGroups = segue.source as? AvailableGroupsController else { return }
// Получаем индекс выделенной ячейки:
            if let indexPath = availableGroups.tableView.indexPathForSelectedRow {
// Получаем группу:
                let group = availableGroups.allGroups[indexPath.row]
                
// Проверяем повторения и отображаем:
                if !myGroups.contains(where: {$0.nameGroup == group.nameGroup}) {
                    myGroups.append(group)
                    tableView.reloadData()
                }
            }
        }
    }
}
