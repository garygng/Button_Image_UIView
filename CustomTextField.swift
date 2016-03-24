//
//  CustomTextField.swift
//  CustomBtnImageView
//
//  Created by Gary.nG on 3/22/16.
//  Copyright © 2016 Gary.nG. All rights reserved.
//
// UITextField: Custom designable and inspectable properties for Corner Radius, Border Color, and Border Width. 
// also allows you to easily set the placeholder color, 
// add a (Left) and Right icon (Clear) icon in the UITextField from your storyboard.

import UIKit

@IBDesignable
class CustomTextField: UITextField {
    
    @IBInspectable var placeholderColor: UIColor = UIColor.lightGrayColor() {
        didSet {
            let canEditPlaceholderColor = self.respondsToSelector(Selector("setAttributedPlaceholder:"))
            
            if (canEditPlaceholderColor) {
                self.attributedPlaceholder = NSAttributedString(string: placeholder!, attributes:[NSForegroundColorAttributeName: placeholderColor]);
            }
        }
    }
    @IBInspectable var borderColor: UIColor? = UIColor.clearColor() {
        didSet {
            layer.borderColor = self.borderColor?.CGColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = self.borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = self.cornerRadius
            layer.masksToBounds = self.cornerRadius > 0
        }
    }
    
    @IBInspectable var leftInset:CGFloat = 0
    @IBInspectable var rightInset:CGFloat = 0
    @IBInspectable var icon:UIImage? { didSet {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 16, height: 16))
        imageView.image = icon
        self.leftView = imageView
        self.leftViewMode = .Always
        } }
    
    @IBInspectable var clearButton:UIImage? { didSet {
        let button = UIButton(type: .Custom)
        button.setImage(clearButton, forState: .Normal)
        button.addTarget(self, action: "clear", forControlEvents: UIControlEvents.TouchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 18, height: 18)
        self.rightView = button
        self.rightViewMode = .WhileEditing
        } }
    
    func clear() {
        self.text = ""
    }
    
    override func leftViewRectForBounds(bounds: CGRect) -> CGRect {
        var height:CGFloat = 0
        var width:CGFloat = 0
        if let leftView = self.leftView {
            height = leftView.bounds.height
            width = leftView.bounds.width
        }
        
        return CGRect(x: leftInset, y: bounds.height/2 - height/2, width: width, height: height)
    }
    
    override func rightViewRectForBounds(bounds: CGRect) -> CGRect {
        var height:CGFloat = 0
        var width:CGFloat = 0
        if let rightView = self.rightView {
            height = rightView.bounds.height
            width = rightView.bounds.width
        }
        
        return CGRect(x: bounds.width - width - rightInset, y: bounds.height/2 - height/2, width: width, height: height)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func drawRect(rect: CGRect) {
        self.layer.cornerRadius = self.cornerRadius
        self.layer.borderWidth = self.borderWidth
        self.layer.borderColor = self.borderColor?.CGColor
    }
}