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
    var imagesUser = [Photo]()
    var images = [Sizes]()
    var titleItem: String?
    var ownerID: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        if let imagesFriendController = showViewControllerAtIndex(0) {
            setViewControllers([imagesFriendController],
                               direction: .forward,
                               animated: true)
            
        }
        
        setupNavigationBar()
    }
    
    func fetchRequestPhotosUser(for id: Int?) {
        
        networkManager.fetchRequestPhotosUser(for: id) { [weak self] photos in
            
            self?.imagesUser = photos
            
            DispatchQueue.main.async {
                
                self?.view.reloadInputViews()
            }
            
            self?.setupSliderView()
        }
    }
    
    private func setupSliderView() {
        
        for imageName in imagesUser {
            
            guard let sizes = imageName.sizes?.last else { return }
            
            images.append(sizes)
            
        }
    }
    
    func showViewControllerAtIndex(_ index: Int) -> ImagesFriendController? {
                
        guard index >= 0, index < images.count,
              let imagesFriendController = storyboard?.instantiateViewController(withIdentifier: "ImagesFriendController") as? ImagesFriendController
        else { return nil }
        
        DispatchQueue.global().async { [weak self] in
            
            guard let url = self?.images[index].src,
                  let imageURL = URL(string: url),
                  let imageData = try? Data(contentsOf: imageURL) else { return }
            
            DispatchQueue.main.async {
                
                imagesFriendController.images = UIImage(data: imageData)
            }
        }
        imagesFriendController.currentPage = index
        imagesFriendController.numberOfPages = images.count
        
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
        
        fetchRequestPhotosUser(for: ownerID)
        return showViewControllerAtIndex(pageNumber)
    }
    
    // Переход вперед
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        var pageNumber = (viewController as! ImagesFriendController).currentPage
        pageNumber += 1
        
        fetchRequestPhotosUser(for: ownerID)
        return showViewControllerAtIndex(pageNumber)
    }
}
