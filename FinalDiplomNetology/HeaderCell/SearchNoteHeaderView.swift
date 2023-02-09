//
//  SearchNoteHeaderView.swift
//  FinalDiplomNetology
//
//  Created by Shalopay on 31.01.2023.
//

import UIKit
class SearchNoteHeaderView: UITableViewHeaderFooterView {
    static var identifier = "SearchNoteHeaderView"
    
    public lazy var titleLabel: CustomLabel = {
        let label = CustomLabel(text: "Мои записи", Fontname: FontTextType.bold.rawValue, Fontsize: 16, UIColorhexRGB: ColorType.LabelTextColor.textOrangeColor.rawValue, lineHeightMultiple: 1.24, kern: 0.16)
        label.textAlignment = .left
        return label
    }()
    
    public lazy var searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.tintColor = UIColor(hexRGB: ColorType.LabelTextColor.textBlackColor.rawValue)
        button.translatesAutoresizingMaskIntoConstraints = false
        //button.addTarget(self, action: #selector(tapingButton), for: .touchUpInside)
        return button
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    private func setupView(){
        contentView.backgroundColor = UIColor(hexRGB: ColorType.ViewColor.backGroundColorView.rawValue)
        contentView.addSubviews([titleLabel, searchButton
        ])
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            
            searchButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            searchButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            searchButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
