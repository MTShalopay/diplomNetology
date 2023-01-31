//
//  Extension+UIVew.swift
//  DiplomWeather
//
//  Created by Shalopay on 12.01.2023.
//

import UIKit
extension UIView {
    func addSubviews(_ views: [UIView]) {
        for view in views {
            self.addSubview(view)
        }
    }
    
    func customBottonLine() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.height / 2, width: self.frame.width, height: 1)
        bottomLine.backgroundColor = UIColor(hexRGB: ColorType.LabelTextColor.textBlackColor.rawValue)?.cgColor
        self.layer.addSublayer(bottomLine)
    }
    
    func customVerticalLine() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: self.frame.width / 2, y: 0, width: 1, height: self.frame.height)
        bottomLine.backgroundColor = UIColor(hexRGB: ColorType.LabelTextColor.textBlackColor.rawValue)?.cgColor
        self.layer.addSublayer(bottomLine)
    }
}

extension UIStackView {
    func addArrangedSubviews(_ views: [UIView]) {
        for view in views {
            self.addArrangedSubview(view)
        }
    }
}
