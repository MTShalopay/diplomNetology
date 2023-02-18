//
//  RecoveryStepOne.swift
//  FinalDiplomNetology
//
//  Created by Shalopay on 28.01.2023.
//

import UIKit
import CoreData

class RecoveryStepOne: UIViewController {
    var coreDataManager = CoreDataManager.shared
    var myPhoneNumber = String()
    var user: User?
    private lazy var textTitleLabel: CustomLabel = {
        let label = CustomLabel(text: "С возвращением", Fontname: FontTextType.medium.rawValue, Fontsize: 22, UIColorhexRGB: ColorType.LabelTextColor.textOrangeColor.rawValue, lineHeightMultiple: 0, kern: 0.18)
        return label
    }()
    
    private lazy var textDescriptionLabel: CustomLabel = {
        let label = CustomLabel(text: "Введите номер телефона \nдля входа в приложение", Fontname: FontTextType.regular.rawValue, Fontsize: 14, UIColorhexRGB: ColorType.LabelTextColor.textBlackColor.rawValue, lineHeightMultiple: 1.18, kern: 0.14)
        label.textAlignment = .center
        label.numberOfLines = 0
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
        let button = CustomButton(title: "ПОДТВЕРДИТЬ",
                                  fontname: FontTextType.regular.rawValue,
                                  fontsize: 19,
                                  backGroundColor: ColorType.ButtonColor.buttonBackGroundBlackColor.rawValue,
                                  textColor: ColorType.LabelTextColor.textWhiteColor.rawValue,
                                  cornerRadius: 10,
                                  lineHeightMultiple: 0,
                                  kern: 0.16)
        button.alpha = 0
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(tapingButton), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = " "
        createNavigationController(isHidden: false)
        setupView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    private func setupView() {
        view.addSubviews([textTitleLabel, textDescriptionLabel, phoneTextField, nextButton
        ])
        NSLayoutConstraint.activate([
            textTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 224),
            textTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textTitleLabel.heightAnchor.constraint(equalToConstant: 22),
            
            textDescriptionLabel.topAnchor.constraint(equalTo: textTitleLabel.bottomAnchor, constant: 26),
            textDescriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textDescriptionLabel.heightAnchor.constraint(equalToConstant: 40),
            textDescriptionLabel.widthAnchor.constraint(equalToConstant: 179),
            
            phoneTextField.topAnchor.constraint(equalTo: textDescriptionLabel.bottomAnchor, constant: 12),
            phoneTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            phoneTextField.heightAnchor.constraint(equalToConstant: 48),
            phoneTextField.widthAnchor.constraint(equalToConstant: 260),
            
            nextButton.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 148),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.heightAnchor.constraint(equalToConstant: 48),
            nextButton.widthAnchor.constraint(equalToConstant: 188),
            
        ])
    }
    @objc private func tapingButton(sender: CustomButton) {
        print(#function)
        let vc = OnBoardingRegisterStepFinish()
        vc.textTitleLabel.isHidden = true
        vc.myPhoneNumber = myPhoneNumber
        let request = NSFetchRequest<NSFetchRequestResult>(entityName:"User")
        request.predicate = NSPredicate(format: "numberPhone == %@", myPhoneNumber)
        do {
            let result = try CoreDataManager.shared.persistentContainer.viewContext.fetch(request) as! [User]
            if result.count == 0 {
                let alertController = UIAlertController(title: "ОШИБКА ВХОДА", message: "Проверте пожалуйста правильность ввода своего номера телефона", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Понятно", style: .cancel, handler: nil)
                alertController.addAction(cancelAction)
                present(alertController, animated: true, completion: nil)
            }
            user = result.first
        } catch let error {
            print(error)
        }
        vc.registerButton = CustomButton(title: "Войти",
                                         fontname: FontTextType.regular.rawValue,
                                         fontsize: 19,
                                         backGroundColor: ColorType.ButtonColor.buttonBackGroundBlackColor.rawValue,
                                         textColor: ColorType.LabelTextColor.textWhiteColor.rawValue,
                                         cornerRadius: 10,
                                         lineHeightMultiple: 0,
                                         kern: 0.16)
        vc.registerButton.addTarget(self, action: #selector(enterAction), for: .touchUpInside)
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc private func enterAction(sender: CustomButton) {
        let mainTB = MainTabBarController()
        mainTB.user = user
        mainTB.modalTransitionStyle = .flipHorizontal
        mainTB.modalPresentationStyle = .fullScreen
        navigationController?.present(mainTB, animated: true, completion: nil)
    }
}

extension RecoveryStepOne: UITextFieldDelegate {
    
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
                } else {
                    nextButton.alpha = 0
                }
                return res.result
            }
            return true
    }
}
