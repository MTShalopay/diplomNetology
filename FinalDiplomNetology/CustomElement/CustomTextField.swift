//
//  CustomTextField.swift
//  FinalDiplomNetology
//
//  Created by Shalopay on 27.01.2023.
//

import UIKit
class CustomTextField: UITextField {
    init(holder: String, colorText: String, cornerRadius: CGFloat) {
        super.init(frame: .zero)
         placeholder = holder
         textColor = UIColor(hexRGB: colorText)
         clipsToBounds = true
         layer.cornerRadius = cornerRadius
         textAlignment = .center
         translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
