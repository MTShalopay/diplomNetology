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
        setupView()
        profileTableView.reloadData()
    }
    
    
    private func setupView() {
        guard let mainTB = tabBarController as? MainTabBarController else {return}
        user = mainTB.user
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
            cellTwo.setupCell(post: post)
            cellTwo.optionButton.addTarget(self, action: #selector(tapingButton), for: .touchUpInside)
            return cellTwo
        default:
            UITableViewCell(frame: .zero)
        }
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            guard let profileHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: ProfileHeaderView.identifier) as? ProfileHeaderView else { return nil }
            profileHeader.user = user
            guard let user = user else {return nil}
            profileHeader.nameLabel.text = "\(user.firstName ?? "Имя") \( user.secondName ?? "Фамилия")"
            profileHeader.professionLabel.text = "\(user.profession ?? "Профессия")"
            let defaultImageData = UIImage(named: "logo")?.pngData()
            profileHeader.profileImageView.image = UIImage(data: user.avatar ?? defaultImageData!)
            
            profileHeader.editButton.addTarget(self, action: #selector(editProfile), for: .touchUpInside)
            
            let tapOnAvatarImageGusture = UITapGestureRecognizer(target: self, action: #selector(tapOnAvatarImage))
            profileHeader.profileImageView.addGestureRecognizer(tapOnAvatarImageGusture)
            profileHeader.profileImageView.isUserInteractionEnabled = true
            
            profileHeader.recordButton.addTarget(self, action: #selector(createPost), for: .touchUpInside)
            
            profileHeader.storiesButton.addTarget(self, action: #selector(createStories), for: .touchUpInside)
            
            profileHeader.photoButton.addTarget(self, action: #selector(createPhoto), for: .touchUpInside)
            
            profileHeader.numberSubscriptionsButton.addTarget(self, action: #selector(goToSubscription), for: .touchUpInside)
            
            profileHeader.numberFoloversButton.addTarget(self, action: #selector(goToSubscription), for: .touchUpInside)
            
                return profileHeader
        case 1:
            guard let headerTwo = tableView.dequeueReusableHeaderFooterView(withIdentifier: SearchNoteHeaderView.identifier) as? SearchNoteHeaderView else { return nil }
                return headerTwo
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
        @unknown default:
            break
        }
    }
    
    @objc private func goToSubscription() {
        print(#function)
        let subscriptionViewController = SubscriptionViewController()
        subscriptionViewController.title = "\(user?.firstName ?? "")"
        navigationController?.pushViewController(subscriptionViewController, animated: true)
    }
    
    @objc private func goToPhotosDetail() {
        print(#function)
        let photosDetail = PhotosDetailViewController()
        photosDetail.user = user
        photosDetail.title = "Фотографии \(user?.firstName ?? " ")"
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
        print(#function)
        let vc = EditProfileViewController()
        vc.delegate = self
        vc.user = user
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
        print(#function)
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
            print("tapOnAvatar")
            DispatchQueue.main.async { [self] in
                guard let imageData = image.jpegData(compressionQuality: 1) else {return}
                profileHeader?.profileImageView.image = UIImage(data: imageData)
                user?.avatar = imageData
                coreDataManager.saveContext()
            }
        case .createStories:
            print("createStories")
            picker.dismiss(animated: true, completion: nil)
            let storiesVC = StoriesViewController()
            DispatchQueue.main.async { [self] in
                storiesVC.storiesImageView.image = image
                storiesVC.nameLabel.text = transliterate(nonLatin: "\(user?.firstName ?? "") \(user?.secondName ?? "")")
                self.present(storiesVC, animated: true) {
                }
            }
        case .createPhoto:
            print("createPhoto")
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
        print(#function)
        picker.dismiss(animated: true, completion: nil)
    }
    
}

//extension ProfileViewController: NSFetchedResultsControllerDelegate {
//
//    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//        profileTableView.beginUpdates()
//    }
//    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
//        switch type {
//        case .insert:
//            print("INSERT:")
//            if let indexPath = indexPath {
//                profileTableView.insertRows(at: [indexPath], with: .automatic)
//            }
//        case .delete:
//            print("DELETE:")
//            if let indexPath = indexPath {
//                profileTableView.deleteRows(at: [indexPath], with: .automatic)
//            }
//        case .move:
//            print("MOVE:")
//            if let indexPath = indexPath {
//                profileTableView.deleteRows(at: [indexPath], with: .automatic)
//            }
//            if let indexPath = newIndexPath {
//                profileTableView.insertRows(at: [indexPath], with: .automatic)
//            }
//        case .update:
//            print("UPDATE:")
//            if let indexPath = indexPath {
//                let user = fetchResultController.object(at: indexPath) as! User
//                    print("section: \(indexPath)")
//                    profileTableView.insertRows(at: [indexPath], with: .automatic)
//            }
////
////            if let indexPath = indexPath {
////
////
//////                let object = fetchResultController.sections?[indexPath.row].objects?[indexPath.row] as? User
////                profileTableView.insertRows(at: [IndexPath(row: indexPath.row, section: 1)], with: .automatic)
////            }
//        @unknown default:
//            break
//        }
//    }
//    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//        profileTableView.endUpdates()
//    }
//}
extension ProfileViewController: ProfileDelegateUpdateTableView {
    func updateTableView() {
        profileTableView.reloadData()
        profileIDLabel.text = transliterate(nonLatin: "\(user?.firstName ?? "") \(user?.secondName ?? "")")
    }
}


