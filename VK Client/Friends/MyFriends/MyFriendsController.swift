//
//  MyFriendsController.swift
//  VK Client
//
//  Created by Eugene Kiselev on 02.08.2020.
//  Copyright © 2020 Eugene Kiselev. All rights reserved.
//

import UIKit

class MyFriendsController: UITableViewController {
    
// Дефолтный массив:
    var friends = [User(nameSurnameFriend: "Иван Иванов", imageFriend: "Иван Иванов"),
                   User(nameSurnameFriend: "Сергей Сергиев", imageFriend: "Сергей Сергиев"),
                   User(nameSurnameFriend: "Дмитрий Дмитров", imageFriend: "Дмитрий Дмитров"),
                   User(nameSurnameFriend: "Алексей Алексеев", imageFriend: "Алексей Алексеев")]

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

// Возвращаем количество элементов массива:
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

// Кастим до MyFriendsCell:
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyFriendsCell", for: indexPath) as! MyFriendsCell
        let friend = friends[indexPath.row]
        
        cell.configure(for: friend)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
// Проверяем идентификатор:
        if segue.identifier == "addImage" {
// Кастим:
            let detailFriendController = segue.destination as? DetailFriendController
// Проверяем выбранную ячейку:
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let image = friends[indexPath.row]
                
                detailFriendController?.friendsImage.removeAll()
                detailFriendController?.friendsImage.append(image)
            }
        }
    }
}
