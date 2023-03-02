//
//  StoriesViewCell.swift
//  FinalDiplomNetology
//
//  Created by Shalopay on 29.01.2023.
//

import UIKit

class StoriesViewCell: UITableViewCell {
    weak var mainViewController: MainViewController?
    static var identifier = "StoriesViewCell"
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    public lazy var imageCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(StoriesCollectionViewCell.self, forCellWithReuseIdentifier: StoriesCollectionViewCell.identifier)
        collectionView.backgroundColor = UIColor(hexRGB: ColorType.ViewColor.backGroundColorView.rawValue)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    private func setupCell() {
        contentView.addSubview(imageCollectionView)
        NSLayoutConstraint.activate([
            imageCollectionView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            imageCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageCollectionView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    private func getStories(user: User?) -> [Stories] {
        var tempArray = [Stories]()
        user?.subscriptions?.allObjects.forEach({ (subscription) in
            if let stories = (subscription as! User).stories {
                tempArray.append(stories)
            }
        })
        return tempArray
    }
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension StoriesViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let stories = getStories(user: CurrentUser)
        return stories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoriesCollectionViewCell.identifier, for: indexPath) as? StoriesCollectionViewCell else {return UICollectionViewCell(frame: .zero)}
        let stories = getStories(user: CurrentUser)
        cell.setupCell(stories: stories[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let stories = getStories(user: CurrentUser)
        let selectStories = stories[indexPath.row]
        let storiesVC = StoriesViewController()
        storiesVC.storiesImageView.image = UIImage(data: selectStories.image!)
        storiesVC.nameLabel.text = transliterate(nonLatin: "\(selectStories.user?.firstName ?? "") \(selectStories.user?.secondName ?? "")")
        storiesVC.pushStoriesButton.isHidden = true
        storiesVC.modalPresentationStyle = .fullScreen
        mainViewController?.present(storiesVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 60)
    }
}
