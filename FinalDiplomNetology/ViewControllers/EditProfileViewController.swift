//
//  EditProfileViewController.swift
//  FinalDiplomNetology
//
//  Created by Shalopay on 01.02.2023.
//

import UIKit

class EditProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    private func setupView() {
        createNavigationController(isHidden: false)
        title = "Основная информация"
        
    }
}
