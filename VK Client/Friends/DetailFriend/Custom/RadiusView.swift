//
//  RadiusView.swift
//  VK Client
//
//  Created by Eugene Kiselev on 21.08.2020.
//  Copyright © 2020 Eugene Kiselev. All rights reserved.
//

import UIKit

@IBDesignable class RadiusView: UIView {

        override func draw(_ rect: CGRect) {
            super.draw(rect)
            
            frame = CGRect(x: 20, y: 20, width: frame.size.width, height: frame.size.height)
            
            layer.cornerRadius = frame.size.height / 2
            clipsToBounds = true
        }
}
