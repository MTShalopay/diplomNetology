//
//  PhotosDetailViewController.swift
//  FinalDiplomNetology
//
//  Created by Shalopay on 16.02.2023.
//

import UIKit

class PhotosDetailViewController: UIViewController {
    var coreDataManager = CoreDataManager.shared
    var user: User?
    
    private enum Constants {
        static let numberOfLine: CGFloat = 3
    }
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        layout.minimumInteritemSpacing = 8
        layout.scrollDirection = .vertical
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.identifier)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "defaultcell")
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    private func setupView() {
        createLoongTap()
        view.backgroundColor = UIColor(hexRGB: ColorType.ViewColor.backGroundColorView.rawValue)
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    @objc private func loongPressTaping(loongTap: UILongPressGestureRecognizer) {
        let cgpoint = loongTap.location(in: collectionView)
        guard let indexPath = collectionView.indexPathForItem(at: cgpoint) else {return}
        if loongTap.state != UIGestureRecognizer.State.ended {
            print("INDEXPATH: \(indexPath)")
            createAlertController(indexPath: indexPath)
        }
    }
    
    private func createLoongTap() {
        let loongTap = UILongPressGestureRecognizer(target: self, action: #selector(loongPressTaping))
        loongTap.minimumPressDuration = 2
        collectionView.addGestureRecognizer(loongTap)
    }
    
    private func createAlertController(indexPath : IndexPath) {
        let alertController = UIAlertController(title: "Внимание", message: "точно удалить фотографию?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Да", style: .default) { _ in
            guard let photo = self.user?.photos?.allObjects[indexPath.row] as? Photo else {return}
            self.coreDataManager.deletePhoto(photo: photo)
            self.collectionView.deleteItems(at: [indexPath])
        }
        let cancelAction = UIAlertAction(title: "Нет", style: .default)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension PhotosDetailViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return user?.photos?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.identifier, for: indexPath) as? PhotosCollectionViewCell else { return collectionView.dequeueReusableCell(withReuseIdentifier: "defaultcell", for: indexPath)}
        if let photo = user?.photos?.allObjects[indexPath.row] as? Photo {
            cell.setupCell(photo: photo)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Section OPS - \(indexPath.section) - Item \(indexPath.item)")
        collectionView.deselectItem(at: indexPath, animated: true)
        let photo = user?.photos?.allObjects[indexPath.row] as? Photo
        
        let fullPhoto = UIImageView()
        fullPhoto.image = UIImage(data: photo?.image ?? defaultImageData!)
        fullPhoto.frame = UIScreen.main.bounds
        fullPhoto.backgroundColor = UIColor(hexRGB: ColorType.LabelTextColor.textBlackColor.rawValue)
        fullPhoto.contentMode = .scaleAspectFit
        fullPhoto.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        fullPhoto.addGestureRecognizer(tap)
            self.view.addSubview(fullPhoto)
            self.navigationController?.isNavigationBarHidden = true
            self.tabBarController?.tabBar.isHidden = true
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing ?? 0
        let insets = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.sectionInset ?? .zero
        let needed = collectionView.frame.width - (Constants.numberOfLine - 1) * spacing - insets.left - insets.right
        let itemwidth = floor(needed / Constants.numberOfLine)
        return CGSize(width: itemwidth, height: itemwidth)
    }
    
    @objc private func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
            self.tabBarController?.tabBar.isHidden = false
            sender.view?.removeFromSuperview()
    }
}
