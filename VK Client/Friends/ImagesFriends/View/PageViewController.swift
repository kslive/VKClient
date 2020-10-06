//
//  PageViewController.swift
//  VK Client
//
//  Created by Eugene Kiselev on 07.09.2020.
//  Copyright © 2020 Eugene Kiselev. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {
    
    let networkManager = NetworkManager()
    var titleItem: String?
    var ownerID: Int?
    var imagesUser = [Photo]()
    var imagesSize = [Sizes]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        fetchRequestPhotosUser(for: ownerID)
        setupNavigationBar()
    }
    
    func fetchRequestPhotosUser(for id: Int?) {
        
        networkManager.fetchRequestPhotosUser(for: id) { [weak self] photos in
            
            self?.imagesUser = photos
            
            DispatchQueue.main.async {
                
                self?.setupView()
                self?.view.reloadInputViews()
            }
            
            self?.setupSliderView()
        }
    }
    
    func setupSliderView() {
        
        for imageName in imagesUser {
            
            guard let sizes = imageName.sizes.last else { return }
            
            imagesSize.append(sizes)
        }
    }
    
    func setupView() {
        
        if let imagesFriendController = showViewControllerAtIndex(0) {
            setViewControllers([imagesFriendController],
                               direction: .forward,
                               animated: true)
            
        }
    }
    
    func showViewControllerAtIndex(_ index: Int) -> ImagesFriendController? {
                        
        guard index >= 0, index < imagesSize.count,
              let imagesFriendController = storyboard?.instantiateViewController(withIdentifier: "ImagesFriendController") as? ImagesFriendController else { return nil }
        
        DispatchQueue.global().async { [weak self] in
            
            guard let url = self?.imagesSize[index].src,
                  let imageURL = URL(string: url),
                  let imageData = try? Data(contentsOf: imageURL) else { return }
            
            DispatchQueue.main.async {
                
                imagesFriendController.imagesFriend.image = UIImage(data: imageData)
                imagesFriendController.view.reloadInputViews()
            }
        }
        imagesFriendController.currentPage = index
        imagesFriendController.numberOfPages = imagesSize.count
        
        return imagesFriendController
    }
    
    
    private func setupNavigationBar() {
        
        if let topItem = navigationController?.navigationBar.topItem {
            
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        
        guard titleItem != nil else { return }
        title = titleItem
    }
}

extension PageViewController: UIPageViewControllerDataSource {
    
    // Переход назад
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        var pageNumber = (viewController as! ImagesFriendController).currentPage
        pageNumber -= 1
        
        return showViewControllerAtIndex(pageNumber)
    }
    
    // Переход вперед
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        var pageNumber = (viewController as! ImagesFriendController).currentPage
        pageNumber += 1
        
        return showViewControllerAtIndex(pageNumber)
    }
}
