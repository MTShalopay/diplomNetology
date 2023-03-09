//
//  PopUpInfoViewController.swift
//  FinalDiplomNetology
//
//  Created by Shalopay on 02.03.2023.
//

import UIKit
class PopUpInfoViewController: UIViewController {
    
    private lazy var infoView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexRGB: ColorType.ViewColor.backGroundColorView.rawValue)
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark.circle"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(closePopUpVC), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    public lazy var titleLabel: CustomLabel = {
        let label = CustomLabel(text: "Информация", Fontname: FontTextType.medium.rawValue, Fontsize: 21, UIColorhexRGB: ColorType.LabelTextColor.textBlackColor.rawValue, lineHeightMultiple: 1.24, kern: 0.16)
        label.textAlignment = .left
        return label
    }()
    public lazy var firstNameLabel: CustomLabel = {
        let label = CustomLabel(text: "Информация", Fontname: FontTextType.medium.rawValue, Fontsize: 18, UIColorhexRGB: ColorType.LabelTextColor.textBlackColor.rawValue, lineHeightMultiple: 1.24, kern: 0.16)
        label.textAlignment = .left
        return label
    }()
    public lazy var secondNameLabel: CustomLabel = {
        let label = CustomLabel(text: "Информация", Fontname: FontTextType.medium.rawValue, Fontsize: 18, UIColorhexRGB: ColorType.LabelTextColor.textBlackColor.rawValue, lineHeightMultiple: 1.24, kern: 0.16)
        label.textAlignment = .left
        return label
    }()
    public lazy var phoneLabel: CustomLabel = {
        let label = CustomLabel(text: "Информация", Fontname: FontTextType.medium.rawValue, Fontsize: 18, UIColorhexRGB: ColorType.LabelTextColor.textBlackColor.rawValue, lineHeightMultiple: 1.24, kern: 0.16)
        label.textAlignment = .left
        return label
    }()
    public lazy var bDayLabel: CustomLabel = {
        let label = CustomLabel(text: "Информация", Fontname: FontTextType.medium.rawValue, Fontsize: 18, UIColorhexRGB: ColorType.LabelTextColor.textBlackColor.rawValue, lineHeightMultiple: 1.24, kern: 0.16)
        label.textAlignment = .left
        return label
    }()
    public lazy var cityLabel: CustomLabel = {
        let label = CustomLabel(text: "Информация", Fontname: FontTextType.medium.rawValue, Fontsize: 18, UIColorhexRGB: ColorType.LabelTextColor.textBlackColor.rawValue, lineHeightMultiple: 1.24, kern: 0.16)
        label.textAlignment = .left
        return label
    }()
    public lazy var professionLabel: CustomLabel = {
        let label = CustomLabel(text: "Информация", Fontname: FontTextType.medium.rawValue, Fontsize: 18, UIColorhexRGB: ColorType.LabelTextColor.textBlackColor.rawValue, lineHeightMultiple: 1.24, kern: 0.16)
        label.textAlignment = .left
        return label
    }()
    
    public lazy var mainVerticalStack: CustomStackView = {
        let stackView = CustomStackView(space: 0, axis: .vertical, distribution: .equalCentering, alignment: .leading)
        return stackView
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupView()
        moveIn()
    }
    
    
    private func setupView() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        view.addSubviews([
                            infoView, cancelButton, titleLabel, mainVerticalStack])
        mainVerticalStack.addArrangedSubviews([firstNameLabel, secondNameLabel, phoneLabel, bDayLabel ,cityLabel, professionLabel
        ])
        NSLayoutConstraint.activate([
            infoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            infoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            infoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            infoView.heightAnchor.constraint(equalToConstant: view.bounds.size.height * 0.30),
            
            cancelButton.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -10),
            cancelButton.topAnchor.constraint(equalTo: infoView.topAnchor, constant: 10),
            cancelButton.heightAnchor.constraint(equalToConstant: 20),
            cancelButton.widthAnchor.constraint(equalToConstant: 20),
            
            titleLabel.centerXAnchor.constraint(equalTo: infoView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: infoView.topAnchor, constant: 20),
            
            mainVerticalStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            mainVerticalStack.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 30),
            mainVerticalStack.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -30),
            mainVerticalStack.bottomAnchor.constraint(equalTo: infoView.bottomAnchor, constant: -10),
        ])
    }
    
    public func enteredUser(user: User?) {
        firstNameLabel.text = "Имя: \(user?.firstName ?? "Не указал")"
        secondNameLabel.text = "Фамилия: \(user?.secondName ?? "Не указанно")"
        phoneLabel.text = "Телефон: \(user?.numberPhone ?? "Не указанно")"
        bDayLabel.text = "День рождение: \(user?.dayBirth ?? "Не указанно")"
        cityLabel.text = "Город: \(user?.city ?? "Не указанно")"
        professionLabel.text = "Профессия: \(user?.profession ?? "Не указанно")"
    }
    
    @objc private func closePopUpVC() {
        moveOut()
    }
    
    private func moveIn() {
        self.view.transform = CGAffineTransform(scaleX: 1.35, y: 1.35)
        self.view.alpha = 0.0
        
        UIView.animate(withDuration: 0.24) {
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self.view.alpha = 1.0
        }
    }
    
    private func moveOut() {
            UIView.animate(withDuration: 0.24, animations: {
                self.view.transform = CGAffineTransform(scaleX: 1.35, y: 1.35)
                self.view.alpha = 0.0
            }) { _ in
                self.view.removeFromSuperview()
            }
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

