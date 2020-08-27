//
//  AvailableGroupsCell.swift
//  VK Client
//
//  Created by Eugene Kiselev on 02.08.2020.
//  Copyright © 2020 Eugene Kiselev. All rights reserved.
//

import UIKit

class AvailableGroupsCell: UITableViewCell {
    
    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var groupImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        groupImage.layer.cornerRadius = groupImage.frame.size.height / 2
        groupImage.contentMode = .scaleAspectFill
    }
    
    func configure(for model: Group) {
        groupNameLabel.text = model.nameGroup
        groupImage.image = UIImage(named: model.imageGroup)
    }
}
