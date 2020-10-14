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
    @IBOutlet weak var animateButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        myGroupImage.layer.cornerRadius = myGroupImage.frame.size.height / 2
        animateButton.layer.cornerRadius = myGroupImage.frame.size.height / 2
        myGroupImage.contentMode = .scaleAspectFill
    }
    
    @IBAction func animatedImage(_ sender: UIButton) {
        
        let animation = CASpringAnimation(keyPath: "transform.scale")
        
        animation.fromValue = 0.8
        animation.toValue = 1
        animation.stiffness = 200
        animation.mass = 5
        animation.duration = 5
        animation.fillMode = CAMediaTimingFillMode.backwards
        
        self.myGroupImage.layer.add(animation, forKey: nil)
    }
    
    func configure(for model: Group) {
        
        guard let name = model.name else { return }
        
        myGroupNameLabel.text = name
        
        guard let url = model.photo50,
              let imageURL = URL(string: url),
              let imageData = try? Data(contentsOf: imageURL) else { return }
        
        DispatchQueue.main.async { [weak self] in
            
            self?.myGroupImage.image = UIImage(data: imageData)
        }
    }
}
