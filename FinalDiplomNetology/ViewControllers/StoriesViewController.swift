//
//  StoriesViewController.swift
//  FinalDiplomNetology
//
//  Created by Shalopay on 04.02.2023.
//

import UIKit

class StoriesViewController: UIViewController {
    public lazy var storiesImageView: UIImageView = {
       let imageView = UIImageView(image: UIImage(named: "logo"))
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .blue
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    public lazy var nameLabel: CustomLabel = {
        let label = CustomLabel(text: "maxim_terentiev", Fontname: FontTextType.medium.rawValue, Fontsize: 12, UIColorhexRGB: ColorType.LabelTextColor.textBlackColor.rawValue, lineHeightMultiple: 1.24, kern: 0.16)
        label.textAlignment = .left
        return label
    }()
    private lazy var exitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "multiply.circle"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    private func setupView() {
        view.addSubviews([
            storiesImageView
        ])
        storiesImageView.addSubviews([
            nameLabel, exitButton
        ])
        NSLayoutConstraint.activate([
            storiesImageView.topAnchor.constraint(equalTo: view.topAnchor),
            storiesImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            storiesImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            storiesImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: storiesImageView.safeAreaLayoutGuide.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: storiesImageView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            nameLabel.heightAnchor.constraint(equalToConstant: 15),
            
            exitButton.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            exitButton.trailingAnchor.constraint(equalTo: storiesImageView.trailingAnchor, constant: -15),
            exitButton.heightAnchor.constraint(equalToConstant: 15),
            exitButton.widthAnchor.constraint(equalToConstant: 15),
        ])
    }
}
