//
//  DetailFriendController.swift
//  VK Client
//
//  Created by Eugene Kiselev on 02.08.2020.
//  Copyright © 2020 Eugene Kiselev. All rights reserved.
//

import UIKit
import RealmSwift

class DetailFriendController: UICollectionViewController {
    
    let networkManager = NetworkManager()
    var friendsImage: Photo?
    var titleItem: String?
    var ownerID: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: Help Function
    
    func fetchRequestPhotosUser(for id: Int?) {
        
        self.networkManager.fetchRequestPhotosUser(for: id) { [weak self] in
            
            do {
                
                let realm = try Realm()
                
                let photo = realm.objects(Photo.self).filter{ $0.ownerId == self?.ownerID}
                
                self?.friendsImage = Array(photo).first
                
                self?.collectionView.reloadData()
            } catch {
                
                print(error)
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
        
        pageViewController?.fetchRequestPhotosUser(for: ownerID)
        pageViewController?.titleItem = titleItem
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
        
        guard let friendImage = friendsImage?.sizes.last else { return cell }
        
        cell.configure(for: friendImage)
        
        return cell
    }
}
