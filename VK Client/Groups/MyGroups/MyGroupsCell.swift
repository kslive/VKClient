//
//  MyGroupsCell.swift
//  VK Client
//
//  Created by Eugene Kiselev on 02.08.2020.
//  Copyright © 2020 Eugene Kiselev. All rights reserved.
//

import UIKit

class MyGroupsCell: UITableViewCell {
    
    @IBOutlet weak var myGroupNameLabel: UILabel!
    @IBOutlet weak var myGroupImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        myGroupImage.layer.cornerRadius = myGroupImage.frame.size.height / 2
        myGroupImage.contentMode = .scaleAspectFill
    }
    
    func configure(for model: Group) {
        myGroupNameLabel.text = model.nameGroup
        myGroupImage.image = UIImage(named: model.imageGroup)
    }
}
