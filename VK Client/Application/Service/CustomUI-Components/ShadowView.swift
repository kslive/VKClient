//
//  ShadowView.swift
//  VK Client
//
//  Created by Eugene Kiselev on 21.08.2020.
//  Copyright © 2020 Eugene Kiselev. All rights reserved.
//

import UIKit

@IBDesignable class ShadowView: UIView {
    
    @IBInspectable var color: UIColor = .green {
        didSet {
            self.updateColor()
        }
    }
    
    @IBInspectable var valueOpacity: Float = 0 {
        didSet {
            self.updateOpacity()
        }
    }
    
    @IBInspectable var radius: CGFloat = 0 {
        didSet {
            self.updateOpacity()
        }
    }
    
    var gradientLayer: CAGradientLayer {
        return self.layer as! CAGradientLayer
    }
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        layer.borderWidth = 25
        layer.borderColor = UIColor.white.cgColor
        
        layer.frame = CGRect(x: 20, y: 20, width: 260, height: 260)
        layer.cornerRadius = frame.size.height / 2
        
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOffset = .zero
        layer.shadowOpacity = valueOpacity
        
        layer.masksToBounds = false
    }
    
    func updateColor() {
        self.gradientLayer.shadowColor = self.color.cgColor
    }
    
    func updateOpacity() {
        self.gradientLayer.shadowOpacity = valueOpacity
    }
    
    func updateRadius() {
        self.gradientLayer.shadowRadius = radius
    }
}
