//
//  UILabel+GDAdd.swift
//  GDKit
//
//  Created by GDKit on 01/11/2022.
//  Copyright (c) 2022 GDKit. All rights reserved.
//

import UIKit

extension UILabel {
    
    public class func gd_label(text: String, font: UIFont, color: UIColor, numberOfLines: Int = 0) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = font
        label.textColor = color
        label.numberOfLines = numberOfLines
        return label
    }
    
    convenience init(gd_text: String, font: UIFont, color: UIColor, numberOfLines: Int = 0) {
        self.init()
        self.text = text
        self.font = font
        self.textColor = color
        self.numberOfLines = numberOfLines
    }
    
}
