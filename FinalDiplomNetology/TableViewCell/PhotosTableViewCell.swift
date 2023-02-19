//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Shalopay on 15.06.2022.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {
    static var identifier: String = "photosTableViewCell"
    var user: User?
    private enum Constants {
        static let numberOfLine: CGFloat = 4
    }
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        layout.minimumInteritemSpacing = 8
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.identifier)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "defaultcell")
        collectionView.backgroundColor = UIColor(hexRGB: ColorType.ViewColor.backGroundColorView.rawValue)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    private lazy var nameLb: CustomLabel = {
        let label = CustomLabel(text: "Фоток \(user?.photos?.count) штук", Fontname: FontTextType.bold.rawValue, Fontsize: 16, UIColorhexRGB: ColorType.LabelTextColor.textBlackColor.rawValue, lineHeightMultiple: 1.24, kern: 0.16)
        return label
    }()
        
    public lazy var rightImage: UIImageView = {
       let rightImage = UIImageView()
        let myImage = UIImage(systemName: "arrow.right")
        rightImage.image = myImage
        rightImage.tintColor = UIColor(hexRGB: ColorType.LabelTextColor.textBlackColor.rawValue)
        rightImage.isUserInteractionEnabled = true
        rightImage.translatesAutoresizingMaskIntoConstraints = false
        return rightImage
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        contentView.backgroundColor = UIColor(hexRGB: ColorType.ViewColor.backGroundColorView.rawValue)
        contentView.addSubview(nameLb)
        contentView.addSubview(rightImage)
        contentView.addSubview(collectionView)
        NSLayoutConstraint.activate([
            nameLb.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 12),
            nameLb.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 12),
            
            rightImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -12),
            rightImage.centerYAnchor.constraint(equalTo: nameLb.centerYAnchor),
            rightImage.heightAnchor.constraint(equalToConstant: 24),
            rightImage.widthAnchor.constraint(equalToConstant: 24),
            
            collectionView.topAnchor.constraint(equalTo: nameLb.bottomAnchor,constant: 12),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            collectionView.heightAnchor.constraint(equalToConstant: 95)
        ])
    }
    
    func setupCell(user: User?) {
        self.user = user
        collectionView.reloadData()
    }
}

extension PhotosTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return user?.photos?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.identifier, for: indexPath) as? PhotosCollectionViewCell else { return collectionView.dequeueReusableCell(withReuseIdentifier: "defaultcell", for: indexPath)}
        let photo = user?.photos?.allObjects[indexPath.row] as! Photo
        cell.setupCell(photo: photo)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("section \(indexPath.section) - item \(indexPath.row)")
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing ?? 0
        let insets = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.sectionInset ?? .zero
        
        let needed = collectionView.frame.width - (Constants.numberOfLine - 1) * spacing - insets.left - insets.right
        let itemwidth = floor(needed / Constants.numberOfLine)
        //print("itemwidth \(itemwidth)")
        return CGSize(width: itemwidth, height: itemwidth)
    }
}
