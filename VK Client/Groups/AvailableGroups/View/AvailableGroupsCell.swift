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
    @IBOutlet weak var animateButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        groupImage.layer.cornerRadius = groupImage.frame.size.height / 2
        animateButton.layer.cornerRadius = groupImage.frame.size.height / 2
        groupImage.contentMode = .scaleAspectFill
    }
    
    @IBAction func animatedImage(_ sender: UIButton) {
        
        let animation = CASpringAnimation(keyPath: "transform.scale")
        
        animation.fromValue = 0.8
        animation.toValue = 1
        animation.stiffness = 200
        animation.mass = 5
        animation.duration = 5
        animation.fillMode = CAMediaTimingFillMode.backwards
        
        self.groupImage.layer.add(animation, forKey: nil)
    }
    
    func configure(for model: Group) {
        
        guard let name = model.name else { return }
        groupNameLabel.text = name
        
        DispatchQueue.global().async {
            
            guard let url = model.photo50,
                  let imageURL = URL(string: url),
                  let imageData = try? Data(contentsOf: imageURL) else { return }
            
            DispatchQueue.main.async { [weak self] in
                
                self?.groupImage.image = UIImage(data: imageData)
            }
        }
    }
}
