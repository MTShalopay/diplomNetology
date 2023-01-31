//
//  ProfileHeaderView.swift
//  FinalDiplomNetology
//
//  Created by Shalopay on 31.01.2023.
//

import UIKit
class ProfileHeaderView: UITableViewHeaderFooterView {
    static var identifier = "ProfileHeaderView"
    
    private lazy var profileImageView: UIImageView = {
       let imageView = UIImageView(image: UIImage(named: "logo"))
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor(hexRGB: ColorType.LabelTextColor.textBlackColor.rawValue)?.cgColor
        imageView.layer.cornerRadius = 30
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var nameLabel: CustomLabel = {
        let label = CustomLabel(text: "Максим Терентьев", Fontname: FontTextType.medium.rawValue, Fontsize: 18, UIColorhexRGB: ColorType.LabelTextColor.textBlackColor.rawValue, lineHeightMultiple: 1.24, kern: 0.16)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var professionLabel: CustomLabel = {
        let label = CustomLabel(text: "IOS developer", Fontname: FontTextType.bold.rawValue, Fontsize: 12, UIColorhexRGB: ColorType.LabelTextColor.textDescriptionColor.rawValue, lineHeightMultiple: 1.24, kern: 0.16)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var infoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "exclamationmark.circle.fill"), for: .normal)
        button.tintColor = UIColor(hexRGB: ColorType.LabelTextColor.textOrangeColor.rawValue)
        button.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        button.setTitle("Подробная информация", for: .normal)
        button.setTitleColor(UIColor(hexRGB: ColorType.LabelTextColor.textBlackColor.rawValue), for: .normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        //button.addTarget(self, action: #selector(changeLike), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var editButton: CustomButton = {
        let button = CustomButton(title: "Редактировать",
                                  fontname: FontTextType.bold.rawValue,
                                  fontsize: 16,
                                  backGroundColor: ColorType.LabelTextColor.textOrangeColor.rawValue,
                                  textColor: ColorType.LabelTextColor.textWhiteColor.rawValue,
                                  cornerRadius: 10,
                                  lineHeightMultiple: 0,
                                  kern: 0.16)
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(editProfile), for: .touchUpInside)
        return button
    }()
    
    private lazy var numberPublicationButton: CustomButton = {
        let button = CustomButton(title: "14\nпубликаций",
                                  fontname: FontTextType.bold.rawValue,
                                  fontsize: 14,
                                  backGroundColor: ColorType.ViewColor.backGroundColorView.rawValue,
                                  textColor: ColorType.LabelTextColor.textBlackColor.rawValue,
                                  cornerRadius: 0,
                                  lineHeightMultiple: 1.18,
                                  kern: 0.16)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        //button.addTarget(self, action: #selector(tapingButton), for: .touchUpInside)
        return button
    }()
    private lazy var numberSubscriptionsButton: CustomButton = {
        let button = CustomButton(title: "14\nподписок",
                                  fontname: FontTextType.bold.rawValue,
                                  fontsize: 14,
                                  backGroundColor: ColorType.ViewColor.backGroundColorView.rawValue,
                                  textColor: ColorType.LabelTextColor.textBlackColor.rawValue,
                                  cornerRadius: 0,
                                  lineHeightMultiple: 1.18,
                                  kern: 0.16)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        //button.addTarget(self, action: #selector(tapingButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var numberFoloversButton: CustomButton = {
        let button = CustomButton(title: "14\nподписчиков",
                                  fontname: FontTextType.bold.rawValue,
                                  fontsize: 14,
                                  backGroundColor: ColorType.ViewColor.backGroundColorView.rawValue,
                                  textColor: ColorType.LabelTextColor.textBlackColor.rawValue,
                                  cornerRadius: 0,
                                  lineHeightMultiple: 1.18,
                                  kern: 0.16)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        //button.addTarget(self, action: #selector(tapingButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var horizontalStack: CustomStackView = {
        let stackView = CustomStackView(space: 0, axis: .horizontal, distribution: .equalCentering, alignment: .center)
        return stackView
    }()
    
    private lazy var horizontalView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexRGB: ColorType.LabelTextColor.textDescriptionColor.rawValue)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var recordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
        button.tintColor = UIColor(hexRGB: ColorType.LabelTextColor.textBlackColor.rawValue)
        button.contentMode = .scaleAspectFit
        button.setTitle("Запись", for: .normal)
        button.setTitleColor(UIColor(hexRGB: ColorType.LabelTextColor.textBlackColor.rawValue), for: .normal)
        //button.addTarget(self, action: #selector(changeLike), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var storiesButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "camera"), for: .normal)
        button.tintColor = UIColor(hexRGB: ColorType.LabelTextColor.textBlackColor.rawValue)
        button.contentMode = .scaleAspectFit
        button.setTitle("История", for: .normal)
        button.setTitleColor(UIColor(hexRGB: ColorType.LabelTextColor.textBlackColor.rawValue), for: .normal)
        //button.addTarget(self, action: #selector(changeLike), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var photoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "photo"), for: .normal)
        button.tintColor = UIColor(hexRGB: ColorType.LabelTextColor.textBlackColor.rawValue)
        button.contentMode = .scaleAspectFit
        button.setTitle("Фото", for: .normal)
        button.setTitleColor(UIColor(hexRGB: ColorType.LabelTextColor.textBlackColor.rawValue), for: .normal)
        //button.addTarget(self, action: #selector(changeLike), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var horizontalButtonStack: CustomStackView = {
        let stackView = CustomStackView(space: 0, axis: .horizontal, distribution: .equalCentering, alignment: .center)
        return stackView
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        recordButton.alignImageAndTitleVertically(padding: 6)
        storiesButton.alignImageAndTitleVertically(padding: 6)
        photoButton.alignImageAndTitleVertically(padding: 6)
    }

    private func setupView() {
        contentView.addSubviews([profileImageView, nameLabel, professionLabel, infoButton, editButton, horizontalStack, horizontalView, horizontalButtonStack
        ])
        horizontalStack.addArrangedSubviews([numberPublicationButton, numberSubscriptionsButton, numberFoloversButton
        ])
        horizontalButtonStack.addArrangedSubviews([recordButton, storiesButton, photoButton])
        
        NSLayoutConstraint.activate([
            profileImageView.heightAnchor.constraint(equalToConstant: 60),
            profileImageView.widthAnchor.constraint(equalToConstant: 60),
            profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 14),
            profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 24),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 14),
            nameLabel.heightAnchor.constraint(equalToConstant: 22),
            
            professionLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 24),
            professionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 3),
            professionLabel.heightAnchor.constraint(equalToConstant: 22),
            
            infoButton.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 24),
            infoButton.topAnchor.constraint(equalTo: professionLabel.bottomAnchor, constant: 3),
            infoButton.heightAnchor.constraint(equalToConstant: 22),
            
            editButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            editButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            editButton.topAnchor.constraint(equalTo: infoButton.bottomAnchor, constant: 25),
            editButton.heightAnchor.constraint(equalToConstant: 47),
            
            horizontalStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            horizontalStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            horizontalStack.topAnchor.constraint(equalTo: editButton.bottomAnchor, constant: 15),
            
            //horizontalView
            horizontalView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            horizontalView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            horizontalView.topAnchor.constraint(equalTo: horizontalStack.bottomAnchor, constant: 2),
            horizontalView.heightAnchor.constraint(equalToConstant: 1),
            
            //recordButton
            //recordButton.heightAnchor.constraint(equalToConstant: 68),
            //storiesButton
            //storiesButton.heightAnchor.constraint(equalToConstant: 68),
            //photoButton
            //photoButton.heightAnchor.constraint(equalToConstant: 68),
            
            //horizontalButtonStack
            horizontalButtonStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            horizontalButtonStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            horizontalButtonStack.topAnchor.constraint(equalTo: horizontalView.bottomAnchor, constant: 2),
            horizontalButtonStack.heightAnchor.constraint(equalToConstant: 68),
            horizontalButtonStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
        ])
    }
    @objc private func editProfile() {
        print(#function)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
