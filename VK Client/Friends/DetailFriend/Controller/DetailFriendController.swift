//
//  DetailFriendController.swift
//  VK Client
//
//  Created by Eugene Kiselev on 02.08.2020.
//  Copyright © 2020 Eugene Kiselev. All rights reserved.
//

import UIKit

class DetailFriendController: UICollectionViewController {
    
    let networkManager = NetworkManager()
    var friendsImage: Photo?
    var titleItem: String?
    var ownerID: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        fetchRequestPhotosUser(for: ownerID)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: Help Function
    
    func fetchRequestPhotosUser(for id: Int?) {
        
        networkManager.fetchRequestPhotosUser(for: id) { [weak self] photos in
                  
            self?.friendsImage = photos.last

            DispatchQueue.main.async {
                
                self?.collectionView.reloadData()
            }
        }
    }
    
    private func setupNavigationBar() {
        
        if let topItem = navigationController?.navigationBar.topItem {
            
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        
        guard titleItem != nil else { return }
        title = titleItem
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard segue.identifier == "seeImages" else { return }
        
        let pageViewController = segue.destination as? PageViewController
        
        pageViewController?.titleItem = titleItem
        pageViewController?.ownerID = ownerID
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailFriendCell", for: indexPath) as! DetailFriendCell
        
        guard let friendImage = friendsImage?.sizes?.last else { return cell }
                    
        cell.configure(for: friendImage)
        
        return cell
    }
}
