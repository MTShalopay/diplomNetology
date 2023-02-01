//
//  ProfileViewController.swift
//  FinalDiplomNetology
//
//  Created by Shalopay on 30.01.2023.
//

import UIKit

protocol ProfileViewControllerDelegate: AnyObject {
    func didTapButton()
}

class ProfileViewController: UIViewController {
    weak var delegate: ProfileViewControllerDelegate?
    
    public lazy var profileIDLabel: CustomLabel = {
        let label = CustomLabel(text: "maxim_terentiev", Fontname: FontTextType.medium.rawValue, Fontsize: 16, UIColorhexRGB: ColorType.LabelTextColor.textBlackColor.rawValue, lineHeightMultiple: 1.24, kern: 0.16)
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
        setupView()
    }
    
    private func setupView() {
        createNavigationController(isHidden: false)
        let settingBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3"), style: .done, target: self, action: #selector(settingTap))
        settingBarButtonItem.tintColor = UIColor(hexRGB: ColorType.LabelTextColor.textOrangeColor.rawValue)
        let titleIDprofile = UIBarButtonItem(customView: profileIDLabel)
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
        return section == 0 ? 1 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cellOne = tableView.dequeueReusableCell(withIdentifier: PhotosTableViewCell.identifier, for: indexPath) as? PhotosTableViewCell else {return UITableViewCell(frame: .zero)}
            cellOne.selectionStyle = .none
            return cellOne
        case 1:
            guard let cellTwo = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as? PostTableViewCell else {return UITableViewCell(frame: .zero)}
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
            guard let headerOne = tableView.dequeueReusableHeaderFooterView(withIdentifier: ProfileHeaderView.identifier) as? ProfileHeaderView else { return nil }
                return headerOne
        case 1:
            guard let headerTwo = tableView.dequeueReusableHeaderFooterView(withIdentifier: SearchNoteHeaderView.identifier) as? SearchNoteHeaderView else { return nil }
                return headerTwo
        default:
            return nil
        }
    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        switch section {
//        case 0:
//            return UITableView.automaticDimension
//        case 1:
//            return UITableView.automaticDimension
//        default:
//            return 0
//        }
//    }
    
}
