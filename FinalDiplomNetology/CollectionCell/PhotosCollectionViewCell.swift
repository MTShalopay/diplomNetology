//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by Shalopay on 16.06.2022.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    static var identifier: String = "photosTableViewCell"
    
     lazy var avaImage: UIImageView = {
       let avaImage = UIImageView()
        avaImage.contentMode = .scaleAspectFill
        avaImage.clipsToBounds = true
        avaImage.layer.cornerRadius = 6
        avaImage.layer.borderWidth = 1
        avaImage.layer.borderColor = UIColor.white.cgColor
        avaImage.translatesAutoresizingMaskIntoConstraints = false
        return avaImage
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.addSubview(avaImage)
        NSLayoutConstraint.activate([
            avaImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            avaImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            avaImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            avaImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}
