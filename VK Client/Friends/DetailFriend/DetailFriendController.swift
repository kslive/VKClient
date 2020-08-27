//
//  DetailFriendController.swift
//  VK Client
//
//  Created by Eugene Kiselev on 02.08.2020.
//  Copyright © 2020 Eugene Kiselev. All rights reserved.
//

import UIKit

class DetailFriendController: UICollectionViewController {
    
    var friendsImage = [User]()
    var titleItem: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
    }
    
    // MARK: Help Function
    
    private func setupNavigationBar() {
// Удаление текста из кнопки возврата:
        if let topItem = navigationController?.navigationBar.topItem {
            
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        
// Передача title:
        guard titleItem != nil else { return }
        title = titleItem
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return friendsImage.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailFriendCell", for: indexPath) as! DetailFriendCell
        let friendImage = friendsImage[indexPath.row]
        
        cell.configure(for: friendImage)
        
        return cell
    }
}
