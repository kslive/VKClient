//
//  ImagesFriendController.swift
//  VK Client
//
//  Created by Eugene Kiselev on 07.09.2020.
//  Copyright © 2020 Eugene Kiselev. All rights reserved.
//

import UIKit

class ImagesFriendController: UIViewController {
    
    var currentPage = 0
    var numberOfPages = 0

    @IBOutlet weak var imagesFriend: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        pageControl.currentPage = currentPage
        pageControl.numberOfPages = numberOfPages
        
        self.tabBarController?.tabBar.isHidden = true
        
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 6.0
    }
}

extension ImagesFriendController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        
        return imagesFriend
    }
}
