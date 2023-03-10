//
//  UIView+Extension.swift
//  RaiseCompany
//
//  Created by mei_yocontrolo on 14/01/2023.
//

import UIKit

extension UIView {
    
    
    @IBInspectable var cornerRadius: CGFloat{
        get {return cornerRadius}
        set {
            self.layer.cornerRadius = newValue
        }
    }
    
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            let color = UIColor.init(cgColor: layer.borderColor!)
            return color
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            
            layer.shadowRadius = shadowRadius
        }
    }
    @IBInspectable
    var shadowOffset : CGSize{
        
        get{
            return layer.shadowOffset
        }set{
            
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor : UIColor{
        get{
            return UIColor.init(cgColor: layer.shadowColor!)
        }
        set {
            layer.shadowColor = newValue.cgColor
        }
    }
    @IBInspectable
    var shadowOpacity : Float {
        
        get{
            return layer.shadowOpacity
        }
        set {
            
            layer.shadowOpacity = newValue
            
        }
    }
    
    @IBInspectable var commonShadow: Bool{
        
        get {
            return false
        }
        set{
            self.layer.shadowOpacity = 0.4
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowOffset = CGSize(width: 2.0, height: 6.0)
            self.layer.shadowRadius = 2
        }
    }
    
    
    @IBInspectable var whiteShadow: Bool{
        
        get {
            return false
        }
        set{
            self.layer.shadowOpacity = 0.5
            self.layer.shadowColor = UIColor.white.cgColor
            self.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
            self.layer.shadowRadius = 2
        }
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    
    
    @IBInspectable var cornerRadiusLabel: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    @IBInspectable var imageRounded: Bool{
        get{
            return false
        }
        
        set{
            layer.masksToBounds = false
            layer.cornerRadius = self.frame.height / 2.25
            clipsToBounds = true
        }
        
    }
    
}

