//
//  OnBoardingRegisterStepFinish.swift
//  FinalDiplomNetology
//
//  Created by Shalopay on 27.01.2023.
//

import UIKit

class OnBoardingRegisterStepFinish: UIViewController {
    var myPhoneNumber: String?
    
    private lazy var textTitleLabel: CustomLabel = {
        let label = CustomLabel(text: "Подтверждение регистрации", Fontname: FontTextType.medium.rawValue, Fontsize: 22, UIColorhexRGB: ColorType.LabelTextColor.textOrangeColor.rawValue, lineHeightMultiple: 0, kern: 0.18)
        return label
    }()
    
    private lazy var textDescriptionLabel: CustomLabel = {
        let label = CustomLabel(text: "Мы отправили SMS с кодом на номер\n\(myPhoneNumber ?? "")", Fontname: FontTextType.regular.rawValue, Fontsize: 14, UIColorhexRGB: ColorType.LabelTextColor.textBlackColor.rawValue, lineHeightMultiple: 1.18, kern: 0.14)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var texttitleSMSLabel: CustomLabel = {
        let label = CustomLabel(text: "Введите код из SMS", Fontname: FontTextType.regular.rawValue, Fontsize: 15, UIColorhexRGB: ColorType.LabelTextColor.textDescriptionColor.rawValue, lineHeightMultiple: 1.03, kern: 0.12)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var smsTextField: CustomTextField = {
        let textField = CustomTextField(holder: "___-___-__", colorText: ColorType.LabelTextColor.textBlackColor.rawValue, cornerRadius: 10)
        textField.delegate = self
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(hexRGB: ColorType.LabelTextColor.textBlackColor.rawValue)?.cgColor
        textField.keyboardType = .phonePad
        textField.clipsToBounds = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var registerButton: CustomButton = {
        let button = CustomButton(title: "ЗАРЕГИСТИРОВАТЬСЯ",
                                  fontname: FontTextType.regular.rawValue,
                                  fontsize: 19,
                                  backGroundColor: ColorType.ButtonColor.buttonBackGroundBlackColor.rawValue,
                                  textColor: ColorType.LabelTextColor.textWhiteColor.rawValue,
                                  cornerRadius: 10,
                                  lineHeightMultiple: 0,
                                  kern: 0.16)
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(registrationAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var logoImageView: UIImageView = {
       let imageView = UIImageView(image: UIImage(named: "Check-mark"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createNavigationController(isHidden: true)
        setupView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    private func setupView() {
        view.addSubviews([textTitleLabel, textDescriptionLabel, texttitleSMSLabel, smsTextField, registerButton, logoImageView
        ])
        NSLayoutConstraint.activate([
            textTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            textTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textTitleLabel.heightAnchor.constraint(equalToConstant: 22),
            
            textDescriptionLabel.topAnchor.constraint(equalTo: textTitleLabel.bottomAnchor, constant: 12),
            textDescriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textDescriptionLabel.heightAnchor.constraint(equalToConstant: 40),
            
            texttitleSMSLabel.topAnchor.constraint(equalTo: textDescriptionLabel.bottomAnchor, constant: 118),
            texttitleSMSLabel.leadingAnchor.constraint(equalTo: smsTextField.leadingAnchor),
            texttitleSMSLabel.heightAnchor.constraint(equalToConstant: 15),
            
            smsTextField.topAnchor.constraint(equalTo: texttitleSMSLabel.bottomAnchor, constant: 5),
            smsTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            smsTextField.heightAnchor.constraint(equalToConstant: 48),
            smsTextField.widthAnchor.constraint(equalToConstant: 260),
            
            registerButton.topAnchor.constraint(equalTo: smsTextField.bottomAnchor, constant: 86),
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerButton.heightAnchor.constraint(equalToConstant: 48),
            registerButton.widthAnchor.constraint(equalToConstant: 260),
            
            logoImageView.heightAnchor.constraint(equalToConstant: 86),
            logoImageView.widthAnchor.constraint(equalToConstant: 100),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 43),
            
        ])
    }
    @objc private func registrationAction() {
        print(#function)
        let mainVC = MainTabBarController()
        mainVC.modalTransitionStyle = .flipHorizontal
        mainVC.modalPresentationStyle = .fullScreen
        navigationController?.present(mainVC, animated: true, completion: nil)
    }
}
extension OnBoardingRegisterStepFinish: UITextFieldDelegate {
    
}
