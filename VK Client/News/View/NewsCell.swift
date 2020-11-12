//
//  NewsCell.swift
//  VK Client
//
//  Created by Eugene Kiselev on 31.08.2020.
//  Copyright © 2020 Eugene Kiselev. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {

    @IBOutlet weak var imageGroup: UIImageView! {
        didSet {
            imageGroup.layer.cornerRadius = imageGroup.frame.size.height / 2
            imageGroup.contentMode = .scaleAspectFill
        }
    }
    
    @IBOutlet weak var nameGroup: UILabel!
    @IBOutlet weak var dateGroup: UILabel!
    @IBOutlet weak var textFromGroup: UILabel!
    @IBOutlet weak var commentsCountLabel: UILabel!
    @IBOutlet weak var likeControl: LikeControl!
    
    func configure(for model: NewsModel) {
        
        self.dateGroup.text = model.getStringDate()
        self.textFromGroup.text = model.text
        self.likeControl.setLike(count: model.likes.count)
        self.nameGroup.text = model.creatorName
        self.commentsCountLabel.text = "\(model.comments.count)"
        
        DispatchQueue.global().async {
            
            guard let url = model.avatarUrl,
                  let imageURL = URL(string: url),
                  let imageData = try? Data(contentsOf: imageURL) else { return }
            
            DispatchQueue.main.async { [weak self] in
                self?.imageGroup.image = UIImage(data: imageData)
            }
        }
    }
}
