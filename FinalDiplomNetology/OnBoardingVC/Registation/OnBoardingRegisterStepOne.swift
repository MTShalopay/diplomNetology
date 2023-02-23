//
//  OnBoardingRegisterStepOne.swift
//  FinalDiplomNetology
//
//  Created by Shalopay on 27.01.2023.
//

import UIKit
import CoreData
class OnBoardingRegisterStepOne: UIViewController {
    var coreDataManager = CoreDataManager.shared
    var myPhoneNumber = String()
    //var user: User?
    
    private lazy var textTitleLabel: CustomLabel = {
        let label = CustomLabel(text: "ЗАРЕГИСТИРОВАТЬСЯ", Fontname: FontTextType.medium.rawValue, Fontsize: 22, UIColorhexRGB: ColorType.LabelTextColor.textBlackColor.rawValue, lineHeightMultiple: 0, kern: 0.18)
        return label
    }()
    
    private lazy var phoneLabel: CustomLabel = {
        let label = CustomLabel(text: "Введите номер", Fontname: FontTextType.bold.rawValue, Fontsize: 24, UIColorhexRGB: ColorType.LabelTextColor.textLightColor.rawValue, lineHeightMultiple: 1.24, kern: 0.16)
        return label
    }()
    
    private lazy var descriptionLabel: CustomLabel = {
        let label = CustomLabel(text: "Ваш номер будет использоваться для входа в аккаунт", Fontname: FontTextType.regular.rawValue, Fontsize: 12, UIColorhexRGB: ColorType.LabelTextColor.textDescriptionColor.rawValue, lineHeightMultiple: 1.03, kern: -0.17)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var phoneTextField: CustomTextField = {
        let textField = CustomTextField(holder: "+7(___)___-__-__", colorText: ColorType.LabelTextColor.textBlackColor.rawValue, cornerRadius: 10)
        textField.delegate = self
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(hexRGB: ColorType.LabelTextColor.textBlackColor.rawValue)?.cgColor
        textField.keyboardType = .phonePad
        textField.clipsToBounds = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var nextButton: CustomButton = {
        let button = CustomButton(title: "ДАЛЕЕ",
                                  fontname: FontTextType.regular.rawValue,
                                  fontsize: 19,
                                  backGroundColor: ColorType.ButtonColor.buttonBackGroundBlackColor.rawValue,
                                  textColor: ColorType.LabelTextColor.textWhiteColor.rawValue,
                                  cornerRadius: 10,
                                  lineHeightMultiple: 0,
                                  kern: 0.16)
        button.titleLabel?.textAlignment = .center
        button.alpha = 0
        button.addTarget(self, action: #selector(tapingButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var descriptionBottonLabel: CustomLabel = {
        let label = CustomLabel(text: "Нажимая кнопку “Далее” Вы принимаете пользовательское Соглашение и политику конфедициальности ", Fontname: FontTextType.regular.rawValue, Fontsize: 12, UIColorhexRGB: ColorType.LabelTextColor.textDescriptionColor.rawValue, lineHeightMultiple: 1.03, kern: -0.17)
        label.numberOfLines = 0
        label.alpha = 0
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createNavigationController(isHidden: false)
        setupView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    private func setupView() {
        title = " "
        view.addSubviews([textTitleLabel, phoneLabel, descriptionLabel, phoneTextField, nextButton, descriptionBottonLabel
        ])
        NSLayoutConstraint.activate([
            textTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            textTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textTitleLabel.heightAnchor.constraint(equalToConstant: 22),
            
            phoneLabel.topAnchor.constraint(equalTo: textTitleLabel.bottomAnchor, constant: 70),
            phoneLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            phoneLabel.heightAnchor.constraint(equalToConstant: 24),
            
            descriptionLabel.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 5),
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 30),
            descriptionLabel.widthAnchor.constraint(equalToConstant: 215),
            
            phoneTextField.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 23),
            phoneTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            phoneTextField.heightAnchor.constraint(equalToConstant: 48),
            phoneTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 57),
            phoneTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -57),
            
            nextButton.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 63),
            nextButton.heightAnchor.constraint(equalToConstant: 48),
            nextButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 127),
            nextButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -128),
            
            descriptionBottonLabel.topAnchor.constraint(equalTo: nextButton.bottomAnchor, constant: 20),
            descriptionBottonLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionBottonLabel.heightAnchor.constraint(equalToConstant: 45),
            descriptionBottonLabel.widthAnchor.constraint(equalToConstant: 258),
        ])
    }
    
    @objc private func tapingButton(sender: UIButton) {
        coreDataManager.chekcUser(for: myPhoneNumber) { [self] (user) in
            if user != nil {
                print("Пользователь есть")
                let alertController = UIAlertController(title: "ОШИБКА ВХОДА", message: "Данный номер \(myPhoneNumber) уже зарегистирован", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Понятно", style: .cancel, handler: nil)
                alertController.addAction(cancelAction)
                present(alertController, animated: true, completion: nil)
                return
            } else {
                print("Пользователя нет")
                CurrentUser = coreDataManager.createUser()
                CurrentUser?.numberPhone = myPhoneNumber
                let vc = OnBoardingRegisterStepFinish()
                vc.myPhoneNumber = myPhoneNumber
                vc.registerType = .registered
                navigationController?.pushViewController(vc, animated: true)
                return
            }
        }
    }
}

extension OnBoardingRegisterStepOne: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
            if (textField == self.phoneTextField) && textField.text == ""{
                textField.text = "+7(" //your country code default
            }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if textField == phoneTextField {
                let res = phoneMask(phoneTextField: phoneTextField, textField: textField, range, string)
                myPhoneNumber = res.phoneNumber != "" ? "+\(res.phoneNumber)" : ""
                if (res.phoneNumber.count == 11) || (res.phoneNumber.count == 0) {
                    nextButton.alpha = 1
                    descriptionBottonLabel.alpha = 1
                } else {
                    nextButton.alpha = 0
                    descriptionBottonLabel.alpha = 0
                }
                return res.result
            }
            return true
    }
}
