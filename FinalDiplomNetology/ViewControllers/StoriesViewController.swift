//
//  StoriesViewController.swift
//  FinalDiplomNetology
//
//  Created by Shalopay on 04.02.2023.
//

import UIKit

class StoriesViewController: UIViewController {
    var coreDataManager = CoreDataManager.shared
    var storiesData: Data?
    
    public lazy var storiesImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .clear
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    public lazy var nameLabel: CustomLabel = {
        let label = CustomLabel(text: "maxim_terentiev", Fontname: FontTextType.medium.rawValue, Fontsize: 12, UIColorhexRGB: ColorType.LabelTextColor.textWhiteColor.rawValue, lineHeightMultiple: 1.24, kern: 0.16)
        label.backgroundColor = UIColor(hexRGB: ColorType.LabelTextColor.textOrangeColor.rawValue)
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.textAlignment = .center
        return label
    }()
    
    private lazy var exitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "multiply.circle"), for: .normal)
        button.tintColor = UIColor(hexRGB: ColorType.LabelTextColor.textWhiteColor.rawValue)
        button.addTarget(self, action: #selector(dissmissVC), for: .touchUpInside)
        button.backgroundColor = UIColor(hexRGB: ColorType.LabelTextColor.textOrangeColor.rawValue)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var pushStoriesButton: CustomButton = {
        let button = CustomButton(title: "Поделиться", fontname: FontTextType.regular.rawValue, fontsize: 20, backGroundColor: ColorType.LabelTextColor.textOrangeColor.rawValue, textColor: ColorType.LabelTextColor.textWhiteColor.rawValue, cornerRadius: 5, lineHeightMultiple: 1.24, kern: 0.16)
        button.addTarget(self, action: #selector(pushStories), for: .touchUpInside)
        button.contentVerticalAlignment = .center
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.addSubviews([
            storiesImageView, nameLabel, exitButton, pushStoriesButton
        ])
        
        NSLayoutConstraint.activate([
            storiesImageView.topAnchor.constraint(equalTo: view.topAnchor),
            storiesImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            storiesImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            storiesImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: storiesImageView.safeAreaLayoutGuide.topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: storiesImageView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            nameLabel.heightAnchor.constraint(equalToConstant: 17),
            nameLabel.widthAnchor.constraint(equalToConstant: (nameLabel.text!.getWidth()) + 10),
            
            exitButton.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            exitButton.trailingAnchor.constraint(equalTo: storiesImageView.trailingAnchor, constant: -15),
            exitButton.heightAnchor.constraint(equalToConstant: 25),
            exitButton.widthAnchor.constraint(equalToConstant: 25),
            
            pushStoriesButton.trailingAnchor.constraint(equalTo: storiesImageView.trailingAnchor, constant: -15),
            pushStoriesButton.bottomAnchor.constraint(equalTo: storiesImageView.bottomAnchor, constant: -35),
        ])
    }
    @objc private func dissmissVC() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func pushStories() {
        print(#function)
        guard let storiesData = storiesData else {return}
        let stories = coreDataManager.createStories(storiesData:storiesData)
        CurrentUser?.stories = stories
        coreDataManager.saveContext()
        dismiss(animated: true, completion: nil)
    }
}
