//
//  StoriesCollectionViewCell.swift
//  FinalDiplomNetology
//
//  Created by Shalopay on 29.01.2023.
//

import UIKit

class StoriesCollectionViewCell: UICollectionViewCell {
    static var identifier = "StoriesCollectionViewCell"
    
    private lazy var storiesImageView: UIImageView = {
       let imageView = UIImageView(image: UIImage(named: "logo"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 30
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor(hexRGB: ColorType.LabelTextColor.textOrangeColor.rawValue)?.cgColor
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    private func setupCell() {
        contentView.addSubview(storiesImageView)
        NSLayoutConstraint.activate([
            storiesImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            storiesImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            storiesImageView.heightAnchor.constraint(equalToConstant: 60),
            storiesImageView.widthAnchor.constraint(equalToConstant: 60),
        ])
    }
    func setupCell(stories: Stories) {
        guard let stories = stories.image else { return }
        storiesImageView.image = UIImage(data: stories)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
