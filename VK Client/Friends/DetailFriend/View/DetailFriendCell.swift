//
//  DetailFriendCell.swift
//  VK Client
//
//  Created by Eugene Kiselev on 02.08.2020.
//  Copyright © 2020 Eugene Kiselev. All rights reserved.
//

import UIKit

class DetailFriendCell: UICollectionViewCell {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var shadowView: ShadowView!
    @IBOutlet weak var detailFriendImage: UIImageView! {
        didSet {
            
            detailFriendImage.layer.cornerRadius = detailFriendImage.frame.size.height / 2
            detailFriendImage.contentMode = .scaleAspectFill
        }
    }
    @IBOutlet weak var imageSliderButton: UIButton! {
        didSet {
            
            imageSliderButton.layer.cornerRadius = detailFriendImage.frame.size.height / 2
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        shadowView.isHidden = true
        setupActivityIndicator()
    }
    
    @IBAction func openedImageSlider(_ sender: UIButton) {
    }
    
    func setupActivityIndicator() {
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .white
        activityIndicator.startAnimating()
    }
    
    func configure(for model: Sizes) {
        
        guard let url = model.src,
              let imageURL = URL(string: url),
              let imageData = try? Data(contentsOf: imageURL) else { return }
        
        DispatchQueue.main.async { [weak self] in
            
            self?.detailFriendImage.image = UIImage(data: imageData)
        }
        
        activityIndicator.stopAnimating()
    }
}
