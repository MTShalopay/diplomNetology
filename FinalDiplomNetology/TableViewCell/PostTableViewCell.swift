//
//  PostTableViewCell.swift
//  FinalDiplomNetology
//
//  Created by Shalopay on 30.01.2023.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    static var identifier = "PostTableViewCell"
    var likeButtonCheck = false
    var likeTotal = 0
    var commitButtonCheck = false
    var commitTotal = 0
    var favoriteButtonCheck = false
    
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
    
    public lazy var optionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        button.tintColor = UIColor(hexRGB: ColorType.LabelTextColor.textOrangeColor.rawValue)
        button.transform = button.transform.rotated(by: .pi / 2)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var backGroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexRGB: ColorType.ViewColor.backGroundColorView.rawValue)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var verticalView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexRGB: ColorType.LabelTextColor.textBlackColor.rawValue)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var postTextLabel: CustomLabel = {
        let label = CustomLabel(text: "Обязательно вступите в группу курса \nв Телеграм группа PRO, вся оперативная информация там, но на первой неделе мы будем присылать рассылку о новых уроках \n", Fontname: FontTextType.bold.rawValue, Fontsize: 14, UIColorhexRGB: ColorType.LabelTextColor.textBlackColor.rawValue, lineHeightMultiple: 1.18, kern: 0.14)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var postImageView: UIImageView = {
       let imageView = UIImageView(image: UIImage(named: "logo"))
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.backgroundColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var horizontalView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexRGB: ColorType.LabelTextColor.textDescriptionColor.rawValue)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "suit.heart"), for: .normal)
        button.tintColor = UIColor(hexRGB: ColorType.LabelTextColor.textOrangeColor.rawValue)
        button.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        button.setTitle("\(likeTotal)", for: .normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(changeLike), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var commitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "message"), for: .normal)
        button.tintColor = UIColor(hexRGB: ColorType.LabelTextColor.textOrangeColor.rawValue)
        button.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        button.setTitle("\(commitTotal)", for: .normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(viewCommit), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "bookmark"), for: .normal)
        button.tintColor = UIColor(hexRGB: ColorType.LabelTextColor.textOrangeColor.rawValue)
        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(isFavorite), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    private func setupView() {
        contentView.backgroundColor = .white
        contentView.addSubviews([
            logoImageView, nameLabel, professionLabel, optionButton, backGroundView
        ])
        backGroundView.addSubviews([ verticalView, postTextLabel, postImageView, horizontalView, likeButton, commitButton, favoriteButton
        ])
        NSLayoutConstraint.activate([
            logoImageView.heightAnchor.constraint(equalToConstant: 60),
            logoImageView.widthAnchor.constraint(equalToConstant: 60),
            logoImageView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 14),
            logoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            nameLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 24),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 14),
            nameLabel.heightAnchor.constraint(equalToConstant: 24),
            
            professionLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 24),
            professionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 3),
            professionLabel.heightAnchor.constraint(equalToConstant: 20),
            
            optionButton.centerYAnchor.constraint(equalTo: logoImageView.centerYAnchor),
            optionButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -16),
            
            backGroundView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            backGroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backGroundView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 12),
            backGroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            verticalView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            verticalView.topAnchor.constraint(equalTo: backGroundView.topAnchor, constant: 16),
            verticalView.widthAnchor.constraint(equalToConstant: 1),
            verticalView.bottomAnchor.constraint(equalTo: horizontalView.topAnchor, constant: -20),
            
            postTextLabel.topAnchor.constraint(equalTo: backGroundView.topAnchor, constant: 5),
            postTextLabel.leadingAnchor.constraint(equalTo: verticalView.trailingAnchor, constant: 15),
            postTextLabel.trailingAnchor.constraint(equalTo: backGroundView.trailingAnchor, constant: -10),
            
            postImageView.topAnchor.constraint(equalTo: postTextLabel.bottomAnchor, constant: 10),
            postImageView.leadingAnchor.constraint(equalTo: verticalView.trailingAnchor, constant: 15),
            postImageView.trailingAnchor.constraint(equalTo: backGroundView.trailingAnchor, constant: -10),
            postImageView.heightAnchor.constraint(equalToConstant: 125),
            
            horizontalView.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 10),
            horizontalView.heightAnchor.constraint(equalToConstant: 1),
            horizontalView.leadingAnchor.constraint(equalTo: backGroundView.leadingAnchor),
            horizontalView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            likeButton.topAnchor.constraint(equalTo: horizontalView.bottomAnchor, constant: 15),
            likeButton.leadingAnchor.constraint(equalTo: postImageView.leadingAnchor, constant: 0),
            
            commitButton.centerYAnchor.constraint(equalTo: likeButton.centerYAnchor),
            commitButton.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor, constant: 30),
            
            //favoriteButton
            favoriteButton.centerYAnchor.constraint(equalTo: likeButton.centerYAnchor),
            favoriteButton.trailingAnchor.constraint(equalTo: backGroundView.trailingAnchor, constant: -16),
            favoriteButton.bottomAnchor.constraint(equalTo: backGroundView.bottomAnchor, constant: -18)
        
        ])
    }
    
    public func setupCell(post: Post) {
        logoImageView.image = UIImage(data: post.user?.avatar ?? defaultImageData!)
        nameLabel.text = "\(post.user?.firstName ?? "Имя") \( post.user?.secondName ?? "Фамилия")"
        professionLabel.text = post.user?.profession ?? "профессия"
        postTextLabel.text = post.text
        postImageView.image = UIImage(data: post.image ?? defaultImageData!)
    }
    
    @objc private func isFavorite(sender: UIButton) {
        print(#function)
        if favoriteButtonCheck == false {
            sender.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
            favoriteButtonCheck = true
        } else {
            sender.setImage(UIImage(systemName: "bookmark"), for: .normal)
            favoriteButtonCheck = false
        }
    }
    
    @objc private func viewCommit(sender: UIButton) {
        print(#function)
        if commitButtonCheck == false {
            sender.setImage(UIImage(systemName: "message.fill"), for: .normal)
            commitButtonCheck = true
        } else {
            sender.setImage(UIImage(systemName: "message"), for: .normal)
            commitButtonCheck = false
        }
    }
    
    @objc private func changeLike(sender: UIButton) {
        if likeButtonCheck == false {
            sender.setImage(UIImage(systemName: "suit.heart.fill"), for: .normal)
            likeTotal += 1
            sender.setTitle("\(likeTotal)", for: .normal)
            likeButtonCheck = true
        } else {
            sender.setImage(UIImage(systemName: "suit.heart"), for: .normal)
            likeTotal -= 1
            sender.setTitle("\(likeTotal)", for: .normal)
            likeButtonCheck = false
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
