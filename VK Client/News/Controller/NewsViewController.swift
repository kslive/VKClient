//
//  NewsViewController.swift
//  VK Client
//
//  Created by Eugene Kiselev on 31.08.2020.
//  Copyright © 2020 Eugene Kiselev. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {
    
    var friendsNews = [User(nameSurnameFriend: "Иванов Иван", imageFriend: ["Иван Иванов", "Иванов Иван"]),
                       User(nameSurnameFriend: "Сергиев Сергей", imageFriend: ["Сергей Сергиев", "Сергиев Сергей"]),
                       User(nameSurnameFriend: "Дмитров Дмитрий", imageFriend: ["Дмитрий Дмитров", "Дмитров Дмитрий"]),
                       User(nameSurnameFriend: "Лукашенко Александр", imageFriend: ["Александр Лукашенко", "Лукашенко Александр"]),
                       User(nameSurnameFriend: "Путин Владимир", imageFriend: ["Владимир Путин", "Путин Владимир"])]

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
