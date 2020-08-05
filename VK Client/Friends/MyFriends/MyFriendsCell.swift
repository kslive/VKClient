//
//  MyFriendsCell.swift
//  VK Client
//
//  Created by Eugene Kiselev on 02.08.2020.
//  Copyright © 2020 Eugene Kiselev. All rights reserved.
//

import UIKit

class MyFriendsCell: UITableViewCell {
    
    @IBOutlet weak var nameSurnameLabel: UILabel!
    @IBOutlet weak var friendImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        friendImage.layer.cornerRadius = friendImage.frame.size.height / 2
        friendImage.contentMode = .scaleAspectFill
    }
    
    func configure(for model: User) {
        nameSurnameLabel.text = model.nameSurnameFriend
        friendImage.image = UIImage(named: model.imageFriend)
    }
}
