//
//  OnBoardingStart.swift
//  FinalDiplomNetology
//
//  Created by Shalopay on 27.01.2023.
//

import UIKit

class OnBoardingStart: UIViewController {
    
    private lazy var logoImageView: UIImageView = {
       let imageView = UIImageView(image: UIImage(named: "logo"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var registerButton: CustomButton = {
        let button = CustomButton(title: "ЗАРЕГИСТИРОВАТЬСЯ",
                                  fontname: FontTextType.bold.rawValue,
                                  fontsize: 19,
                                  backGroundColor: ColorType.ButtonColor.buttonBackGroundBlackColor.rawValue,
                                  textColor: ColorType.LabelTextColor.textWhiteColor.rawValue,
                                  cornerRadius: 10,
                                  lineHeightMultiple: 0,
                                  kern: 0.16)
        button.titleLabel?.textAlignment = .center
        button.tag = 0
        button.addTarget(self, action: #selector(tapingButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var enterButton: CustomButton = {
        let button = CustomButton(title: "уже есть аккаунт",
                                  fontname: FontTextType.regular.rawValue,
                                  fontsize: 18,
                                  backGroundColor: ColorType.ViewColor.backGroundColorView.rawValue,
                                  textColor: ColorType.LabelTextColor.textBlackColor.rawValue,
                                  cornerRadius: 0,
                                  lineHeightMultiple: 1.18,
                                  kern: -0.16)
        button.titleLabel?.textAlignment = .center
        button.tag = 1
        button.addTarget(self, action: #selector(tapingButton), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        title = " "
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = UIColor(hexRGB: ColorType.ViewColor.backGroundColorView.rawValue)
        view.addSubviews([logoImageView, registerButton, enterButton
        ])
        NSLayoutConstraint.activate([
            logoImageView.heightAnchor.constraint(equalToConstant: 344),
            logoImageView.widthAnchor.constraint(equalToConstant: 344),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            
            registerButton.centerXAnchor.constraint(equalTo: logoImageView.centerXAnchor),
            registerButton.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 80),
            registerButton.heightAnchor.constraint(equalToConstant: 47),
            registerButton.widthAnchor.constraint(equalToConstant: 261),
            
            enterButton.centerXAnchor.constraint(equalTo: registerButton.centerXAnchor),
            enterButton.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 30),
            enterButton.heightAnchor.constraint(equalToConstant: 20),
            
        ])
    }
    
    @objc private func tapingButton(sender: CustomButton) {
        switch sender.tag {
        case 0:
            print("11")
            let registerVC = OnBoardingRegisterStepOne()
            self.navigationController?.pushViewController(registerVC, animated: true)
        case 1:
            print("00")
            let recoveryVC = RecoveryStepOne()
            self.navigationController?.pushViewController(recoveryVC, animated: true)
        default:
            fatalError()
        }
    }

}

