//
//  CustomButton.swift
//  FinalDiplomNetology
//
//  Created by Shalopay on 27.01.2023.
//

import UIKit
class CustomButton: UIButton {
    let paragraphStyle: NSMutableParagraphStyle = NSMutableParagraphStyle()
    init(title: String, fontname: String, fontsize: CGFloat, backGroundColor: String, textColor: String, cornerRadius: CGFloat, lineHeightMultiple: CGFloat, kern: Double) {
        super.init(frame: .zero)
        titleLabel?.font = UIFont(name: fontname, size: fontsize)
        backgroundColor = UIColor(hexRGB: backGroundColor)
        titleLabel?.textColor = UIColor(hexRGB: textColor)
        layer.cornerRadius = cornerRadius
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        setAttributedTitle(NSAttributedString(string: title, attributes: [NSAttributedString.Key.paragraphStyle : paragraphStyle, NSAttributedString.Key.kern: kern]), for: .normal)
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
