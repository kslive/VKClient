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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        detailFriendImage.contentMode = .scaleAspectFill
    }
    
    func configure(for model: User) {
        
        detailFriendImage.image = UIImage(named: model.imageFriend)
    }
}
