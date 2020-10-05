//
//  NewsViewController.swift
//  VK Client
//
//  Created by Eugene Kiselev on 31.08.2020.
//  Copyright © 2020 Eugene Kiselev. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {
    
    var friendsNews = [User]()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
