//
//  Extension+UIViewController.swift
//  FinalDiplomNetology
//
//  Created by Shalopay on 28.01.2023.
//

import UIKit
extension UIViewController {
    func createNavigationController(isHidden: Bool) {
        view.backgroundColor = UIColor(hexRGB: ColorType.ViewColor.backGroundColorView.rawValue)
        navigationController?.navigationItem.backBarButtonItem?.title = " "
        navigationController?.navigationBar.tintColor = UIColor(hexRGB: ColorType.LabelTextColor.textBlackColor.rawValue)
        navigationController?.navigationBar.isHidden = isHidden
        navigationController?.navigationBar.barTintColor = UIColor(hexRGB: ColorType.ViewColor.backGroundColorView.rawValue)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func addChildVC(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func removeChildVC() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}

