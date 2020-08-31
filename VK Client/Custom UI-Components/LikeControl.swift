//
//  LikeControl.swift
//  VK Client
//
//  Created by Eugene Kiselev on 21.08.2020.
//  Copyright © 2020 Eugene Kiselev. All rights reserved.
//

import UIKit

@IBDesignable class LikeControl: UIControl {
    
    var imageView = UIImageView()
    var likeCountLabel = UILabel()
    
    var likeCounter = 0
    var isLike: Bool = false
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.frame = bounds
    }
    
    func setLike(count: Int){
        
        likeCounter = count
        setLikeCounterLabel()
    }
    
    func setView() {
        
        self.addSubview(imageView)
        self.addTarget(self, action: #selector(tapControl), for: .touchUpInside)
        
        imageView.tintColor = .white
        imageView.image = UIImage(systemName: "heart")
        
        setLikeCounterLabel()
    }
    
    func setLikeCounterLabel() {
        
        addSubview(likeCountLabel)
        
        likeCountLabel.text = String(likeCounter)
        likeCountLabel.textColor = .white
        likeCountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        likeCountLabel.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: -8).isActive = true
        likeCountLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
    }
    
    @objc func tapControl(){
        
        isLike.toggle()
        
        if isLike {
            
            imageView.image = UIImage(systemName: "heart.fill")
            likeCounter += 1
            setLikeCounterLabel()
        } else {
            
            imageView.image = UIImage(systemName: "heart")
            likeCounter -= 1
            setLikeCounterLabel()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.setView()
    }
}




