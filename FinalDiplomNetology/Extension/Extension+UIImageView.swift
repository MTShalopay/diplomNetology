//
//  Extension+UIImageView.swift
//  DiplomWeather
//
//  Created by Shalopay on 18.01.2023.
//

import UIKit

extension UIImageView {
  func setImageColor(color: UIColor) {
    let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
    self.image = templateImage
    self.tintColor = color
  }
    
}
