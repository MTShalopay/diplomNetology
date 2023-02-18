//
//  MainHeaderView.swift
//  FinalDiplomNetology
//
//  Created by Shalopay on 29.01.2023.
//

import UIKit

class MainHeaderView: UITableViewHeaderFooterView {
    static var identifier = "MainHeaderView"
    
    private lazy var leftView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexRGB: ColorType.LabelTextColor.textBlackColor.rawValue)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var dateTitleLabel: CustomLabel = {
        let label = CustomLabel(text: "13 июня", Fontname: FontTextType.medium.rawValue, Fontsize: 14, UIColorhexRGB: ColorType.LabelTextColor.textDescriptionColor.rawValue, lineHeightMultiple: 1.18, kern: 0.14)
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor(hexRGB: ColorType.LabelTextColor.textBlackColor.rawValue)?.cgColor
        label.layer.cornerRadius = 5
        label.textAlignment = .center
        return label
    }()
    
    private lazy var rightView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexRGB: ColorType.LabelTextColor.textBlackColor.rawValue)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    private func setupView(){
        leftView.customBottonLine()
        contentView.addSubviews([leftView, dateTitleLabel ,rightView])
        NSLayoutConstraint.activate([
            leftView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            leftView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            leftView.heightAnchor.constraint(equalToConstant: 1),
            leftView.trailingAnchor.constraint(equalTo: dateTitleLabel.leadingAnchor, constant: -10),
            
            rightView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            rightView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            rightView.heightAnchor.constraint(equalToConstant: 1),
            rightView.leadingAnchor.constraint(equalTo: dateTitleLabel.trailingAnchor, constant: 10),
            
            dateTitleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            dateTitleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            dateTitleLabel.heightAnchor.constraint(equalToConstant: 24),
            dateTitleLabel.widthAnchor.constraint(equalToConstant: (dateTitleLabel.text?.getWidth() ?? 0) + 44),
            dateTitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
            
            
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
