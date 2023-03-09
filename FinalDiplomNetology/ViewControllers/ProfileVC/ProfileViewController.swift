//
//  ProfileViewController.swift
//  FinalDiplomNetology
//
//  Created by Shalopay on 30.01.2023.
//

import UIKit
import CoreData

protocol ProfileDelegateUpdateTableView: AnyObject {
    func updateTableView()
}

protocol ProfileViewControllerDelegate: AnyObject {
    func didTapButton()
}

class ProfileViewController: UIViewController {
    enum ActionType {
        case tapOnAvatar
        case createStories
        case createPhoto
    }
    var action: ActionType = .tapOnAvatar
    var coreDataManager = CoreDataManager.shared
    var user: User?
    weak var delegate: ProfileViewControllerDelegate?
    
    public lazy var profileIDLabel: CustomLabel = {
        let label = CustomLabel(text: "", Fontname: FontTextType.medium.rawValue, Fontsize: 16, UIColorhexRGB: ColorType.LabelTextColor.textBlackColor.rawValue, lineHeightMultiple: 1.24, kern: 0.16)
        label.textAlignment = .left
        return label
    }()
    
    public lazy var profileTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 200
        tableView.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: ProfileHeaderView.identifier)
        tableView.register(SearchNoteHeaderView.self, forHeaderFooterViewReuseIdentifier: SearchNoteHeaderView.identifier)
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: PhotosTableViewCell.identifier)
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
        tableView.showsVerticalScrollIndicator = false
        tableView.alwaysBounceVertical = false
        tableView.backgroundColor = UIColor(hexRGB: ColorType.ViewColor.backGroundColorView.rawValue)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if user == nil {
            user = CurrentUser
        }
        setupView()
        profileTableView.reloadData()
    }
    
    
    private func setupView() {
        createNavigationController(isHidden: false)
        let settingBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3"), style: .done, target: self, action: #selector(settingTap))
        settingBarButtonItem.tintColor = UIColor(hexRGB: ColorType.LabelTextColor.textOrangeColor.rawValue)
        let titleIDprofile = UIBarButtonItem(customView: profileIDLabel)
        navigationController?.navigationBar.topItem?.title = " "
        navigationItem.setLeftBarButton(titleIDprofile, animated: false)
        navigationItem.rightBarButtonItem = settingBarButtonItem
        
        view.addSubview(profileTableView)
        NSLayoutConstraint.activate([
            profileTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            profileTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            profileTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    @objc private func settingTap(sender: UIBarButtonItem) {
        delegate?.didTapButton()
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            if let photo = user?.photos, photo.count > 0 {
                return 1
            }
            return 0
        case 1:
            return user?.posts?.count ?? 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cellOne = tableView.dequeueReusableCell(withIdentifier: PhotosTableViewCell.identifier, for: indexPath) as? PhotosTableViewCell else {return UITableViewCell(frame: .zero)}
            cellOne.setupCell(user: user)
            cellOne.selectionStyle = .none
            
            let rightImageTap = UITapGestureRecognizer(target: self, action: #selector(goToPhotosDetail))
            cellOne.rightImage.addGestureRecognizer(rightImageTap)
            
            return cellOne
        case 1:
            guard let cellTwo = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as? PostTableViewCell else {return UITableViewCell(frame: .zero)}
            let post = user?.posts?.allObjects[indexPath.row] as! Post
            cellTwo.post = post
            cellTwo.setupCell(post: post)
            cellTwo.setFavoriteImage()
            if user?.uuID == CurrentUser?.uuID {
                cellTwo.optionButton.addTarget(self, action: #selector(tapingButton), for: .touchUpInside)
            } else {
                cellTwo.optionButton.isHidden = true
            }
            return cellTwo
        default:
            break
        }
        return UITableViewCell(frame: .zero)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            guard let profileHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: ProfileHeaderView.identifier) as? ProfileHeaderView else { return nil }
            profileHeader.user = user
            profileHeader.setSubscribeButtonText()
            guard let user = user else {return nil}
            
            profileHeader.numberPublicationButton.setAttributedTitle(NSAttributedString(string: "\(user.posts?.count ?? 0)\nпубликаций", attributes: [ NSAttributedString.Key.kern: 1.06]), for: .normal)
            
            profileHeader.numberFoloversButton.setAttributedTitle(NSAttributedString(string: "\(user.followers?.count ?? 0)\nподписчиков", attributes: [ NSAttributedString.Key.kern: 1.06]), for: .normal)
            
            profileHeader.numberSubscriptionsButton.setAttributedTitle(NSAttributedString(string: "\(user.subscriptions?.count ?? 0)\nподписок", attributes: [ NSAttributedString.Key.kern: 1.06]), for: .normal)
            
            profileHeader.nameLabel.text = "\(user.firstName ?? "Имя") \( user.secondName ?? "Фамилия")"
            profileHeader.professionLabel.text = "\(user.profession ?? "Профессия")"
            let defaultImageData = UIImage(named: "logo")?.pngData()
            profileHeader.profileImageView.image = UIImage(data: user.avatar ?? defaultImageData!)
            
            profileHeader.editButton.addTarget(self, action: #selector(editProfile), for: .touchUpInside)
            
            profileHeader.infoButton.addTarget(self, action: #selector(presentPopUpInfoVC), for: .touchUpInside)
            
            let tapOnAvatarImageGusture = UITapGestureRecognizer(target: self, action: #selector(tapOnAvatarImage))
            profileHeader.profileImageView.addGestureRecognizer(tapOnAvatarImageGusture)
            profileHeader.profileImageView.isUserInteractionEnabled = true
            
            profileHeader.recordButton.addTarget(self, action: #selector(createPost), for: .touchUpInside)
            
            profileHeader.storiesButton.addTarget(self, action: #selector(createStories), for: .touchUpInside)
            
            profileHeader.photoButton.addTarget(self, action: #selector(createPhoto), for: .touchUpInside)
            
            profileHeader.numberSubscriptionsButton.addTarget(self, action: #selector(goToSubscription), for: .touchUpInside)
            
            profileHeader.numberFoloversButton.addTarget(self, action: #selector(goToSubscription), for: .touchUpInside)
            
            if user.uuID == CurrentUser?.uuID {
                profileHeader.profileImageView.isUserInteractionEnabled = true
                profileHeader.profileImageView.image = UIImage(data: user.avatar ?? defaultImageData!)
                profileHeader.nameLabel.text = "\(user.firstName ?? "Имя") \(user.secondName ?? "Фамилия")"
                profileHeader.professionLabel.text = user.profession
                profileHeader.editButton.isHidden = false
                profileHeader.subscribersButtonStack.isHidden = true
                profileHeader.horizontalButtonStack.isHidden = false
            } else {
                profileHeader.profileImageView.isUserInteractionEnabled = false
                profileHeader.profileImageView.image = UIImage(data: user.avatar ?? defaultImageData!)
                profileHeader.nameLabel.text = "\(user.firstName ?? "Имя") \(user.secondName ?? "Фамилия")"
                profileHeader.professionLabel.text = user.profession
                profileHeader.editButton.isHidden = true
                profileHeader.subscribersButtonStack.isHidden = false
                profileHeader.horizontalButtonStack.isHidden = true
            }
                return profileHeader
        case 1:
            guard let searchNoteHeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: SearchNoteHeaderView.identifier) as? SearchNoteHeaderView else { return nil }
            
            if user?.uuID == CurrentUser?.uuID {
                searchNoteHeaderView.searchButton.isHidden = false
            } else {
                searchNoteHeaderView.searchButton.isHidden = true
                searchNoteHeaderView.titleLabel.attributedText = NSAttributedString(string: "Посты \(user?.firstName ?? "")", attributes: [ NSAttributedString.Key.kern: 0.16])
            }
                return searchNoteHeaderView
        default:
            return nil
        }
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.section == 0 {
            return false
        }
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            switch editingStyle {
            case .delete:
                if let post = user?.posts?.allObjects[indexPath.row] as? Post {
                    coreDataManager.deletePost(post: post)
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                }
            case .none:
                break
            case .insert:
                break
            @unknown default:
                break
            }
    }
    
    @objc private func presentPopUpInfoVC() {
        let vc = PopUpInfoViewController()
        vc.enteredUser(user: user)
        self.addChild(vc)
        vc.view.frame = view.frame
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
    }
    
    @objc private func goToSubscription(sender: UIButton) {
        let subscriptionViewController = SubscriptionViewController()
        subscriptionViewController.title = "\(user?.firstName ?? "")"
        if sender.tag == 0 {
            subscriptionViewController.subscriptionSegmentControl.selectedSegmentIndex = 0
        } else {
            subscriptionViewController.subscriptionSegmentControl.selectedSegmentIndex = 1
        }
        navigationController?.pushViewController(subscriptionViewController, animated: true)
    }
    
    @objc private func goToPhotosDetail() {
        let photosDetail = PhotosDetailViewController()
        photosDetail.user = user
        photosDetail.title = "Фотографии \(user?.firstName ?? " ")"
        photosDetail.navigationItem.backButtonTitle = " "
        navigationController?.pushViewController(photosDetail, animated: true)
    }
    
    @objc private func tapingButton(sender: UIButton) {
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to: profileTableView)
        guard let indexPath = profileTableView.indexPathForRow(at: buttonPosition), let post = user?.posts?.allObjects[indexPath.row] as? Post else {return}
            coreDataManager.deletePost(post: post)
            profileTableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    private func getImagePicker(source: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        imagePicker.sourceType = source
        present(imagePicker, animated: true, completion: nil)
    }
    @objc private func editProfile() {
        let vc = EditProfileViewController()
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }
    
    //MARK: tapOnAvatarImage
    @objc private func tapOnAvatarImage() {
        action = .tapOnAvatar
        getImagePicker(source: .photoLibrary)
    }
    
    //MARK: createPhoto
    @objc private func createPhoto(sender: UIButton) {
        action = .createPhoto
        getImagePicker(source: .photoLibrary)
        
    }
    //MARK: createStories
    @objc private func createStories(sender: UIButton) {
        action = .createStories
        getImagePicker(source: .photoLibrary)
    }
    
    //MARK: createPost
    @objc private func createPost(sender: UIButton) {
        let addPostVC = AddPostViewController()
        addPostVC.delegate = self
        addPostVC.user = user
        let addPostNC = UINavigationController(rootViewController: addPostVC)
        present(addPostNC, animated: true, completion: nil)
    }
}
extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let profileHeader = self.profileTableView.headerView(forSection: 0) as? ProfileHeaderView
        guard let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage else {return}
        
        switch action {
        case .tapOnAvatar:
            DispatchQueue.main.async { [self] in
                guard let imageData = image.jpegData(compressionQuality: 1) else {return}
                profileHeader?.profileImageView.image = UIImage(data: imageData)
                user?.avatar = imageData
                coreDataManager.saveContext()
                profileTableView.reloadData()
            }
        case .createStories:
            picker.dismiss(animated: true, completion: nil)
            let storiesVC = StoriesViewController()
            DispatchQueue.main.async { [self] in
                guard let storiesData = image.jpegData(compressionQuality: 1) else {return}
                storiesVC.storiesImageView.image = image
                storiesVC.nameLabel.text = transliterate(nonLatin: "\(user?.firstName ?? "") \(user?.secondName ?? "")")
                self.present(storiesVC, animated: true) {
                    storiesVC.storiesData = storiesData
                }
            }
        case .createPhoto:
            guard let imageData = image.jpegData(compressionQuality: 1) else {return}
            let photo = coreDataManager.createPhoto(imageData: imageData)
            user?.addToPhotos(photo)
            DispatchQueue.main.async { [self] in
                profileTableView.reloadData()
            }
            coreDataManager.saveContext()
            
        }
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension ProfileViewController: ProfileDelegateUpdateTableView {
    func updateTableView() {
        profileTableView.reloadData()
        profileIDLabel.text = transliterate(nonLatin: "\(user?.firstName ?? "") \(user?.secondName ?? "")")
    }
}


