//
//  SearchViewCell.swift
//  FinalDiplomNetology
//
//  Created by Shalopay on 16.02.2023.
//

import UIKit
class SearchViewCell: UITableViewCell {
    static var identifier: String = "SearchViewCell"
    
    private lazy var logoImageView: UIImageView = {
       let imageView = UIImageView(image: UIImage(named: "logo"))
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor(hexRGB: ColorType.LabelTextColor.textBlackColor.rawValue)?.cgColor
        imageView.layer.cornerRadius = 30
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var nameLabel: CustomLabel = {
        let label = CustomLabel(text: "Максим Терентьев", Fontname: FontTextType.medium.rawValue, Fontsize: 16, UIColorhexRGB: ColorType.LabelTextColor.textBlackColor.rawValue, lineHeightMultiple: 1.24, kern: 0.16)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var professionLabel: CustomLabel = {
        let label = CustomLabel(text: "IOS developer", Fontname: FontTextType.bold.rawValue, Fontsize: 14, UIColorhexRGB: ColorType.LabelTextColor.textLightColor.rawValue, lineHeightMultiple: 1.24, kern: 0.16)
        label.textAlignment = .left
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        
    }
    
    private func setupView() {
        contentView.layer.cornerRadius = 10
        contentView.layer.borderColor = UIColor(hexRGB: ColorType.LabelTextColor.textBlackColor.rawValue)?.cgColor
        contentView.layer.borderWidth = 1
        contentView.addSubviews([
            logoImageView, nameLabel, professionLabel
        ])
        NSLayoutConstraint.activate([
            logoImageView.heightAnchor.constraint(equalToConstant: 60),
            logoImageView.widthAnchor.constraint(equalToConstant: 60),
            logoImageView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 14),
            logoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            logoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -14),
            
            nameLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 24),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 14),
            nameLabel.heightAnchor.constraint(equalToConstant: 24),
            
            professionLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 24),
            professionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 3),
            professionLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
    
    public func setupCell(user: User) {
        let defaultImageData = UIImage(named: "logo")?.pngData()
        logoImageView.image = UIImage(data: user.avatar ?? defaultImageData!)
        nameLabel.text = "\(user.firstName ?? "Имя") \( user.secondName ?? "Фамилия")"
        professionLabel.text = user.profession ?? "профессия"
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
