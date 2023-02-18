//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by Shalopay on 16.06.2022.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    static var identifier: String = "photosTableViewCell"
    
     lazy var userImage: UIImageView = {
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
        contentView.addSubview(userImage)
        NSLayoutConstraint.activate([
            userImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            userImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            userImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            userImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    func setupCell(photo: Photo) {
        let defaultImageData = UIImage(named: "logo")?.pngData()
        userImage.image = UIImage(data: photo.image ?? defaultImageData!)
    }
}
