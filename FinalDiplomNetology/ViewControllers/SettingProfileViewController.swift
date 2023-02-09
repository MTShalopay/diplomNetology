//
//  SettingProfileViewController.swift
//  FinalDiplomNetology
//
//  Created by Shalopay on 31.01.2023.
//

import UIKit
protocol SettingProfileViewControllerDelegate: AnyObject {
    func didSelect(menuItem: SettingProfileViewController.SettingOption)
}

class SettingProfileViewController: UIViewController {
    weak var delegate: SettingProfileViewControllerDelegate?
    
    enum SettingOption: String, CaseIterable {
        case profile = "Профиль"
        case setting = "Настройки"
        case exit = "Выход из профиля"
        
        var imageName: String {
            switch self {
            case .profile:
                return "person.crop.square"
            case .setting:
                return "gear"
            case .exit:
                return "figure.walk.circle"
            }
        }
    }
    public lazy var titleLabel: CustomLabel = {
        let label = CustomLabel(text: "Меню", Fontname: FontTextType.medium.rawValue, Fontsize: 26, UIColorhexRGB: ColorType.LabelTextColor.textBlackColor.rawValue, lineHeightMultiple: 1.18, kern: -0.17)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var settingTableView: UITableView = {
       let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .none
        tableView.isScrollEnabled = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    
    private func setupView() {
        view.backgroundColor = UIColor(hexRGB:"#F5F3EE")
        view.addSubviews([titleLabel, settingTableView])
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 110),
            
            settingTableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 10),
            settingTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 100),
            settingTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            settingTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension SettingProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingOption.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .none
        cell.contentView.backgroundColor = .none
        cell.textLabel?.text = SettingOption.allCases[indexPath.row].rawValue
        cell.imageView?.image = UIImage(systemName: SettingOption.allCases[indexPath.row].imageName)
        cell.imageView?.tintColor = .black
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let menuItem = SettingOption.allCases[indexPath.row]
        delegate?.didSelect(menuItem: menuItem)
        
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    
}
