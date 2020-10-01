//
//  DetailFriendCell.swift
//  VK Client
//
//  Created by Eugene Kiselev on 02.08.2020.
//  Copyright © 2020 Eugene Kiselev. All rights reserved.
//

import UIKit

class DetailFriendCell: UICollectionViewCell {
    
    @IBOutlet weak var detailFriendImage: UIImageView!
    @IBOutlet weak var imageSliderButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        detailFriendImage.contentMode = .scaleAspectFill
        imageSliderButton.layer.cornerRadius = detailFriendImage.frame.size.height / 2
    }
    
    @IBAction func openedImageSlider(_ sender: UIButton) {
    }
    
    func configure(for model: User) {
        
//        detailFriendImage.image = UIImage(named: model.imageFriend.first!)
    }
}
