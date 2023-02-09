//
//  EditProfileViewController.swift
//  FinalDiplomNetology
//
//  Created by Shalopay on 01.02.2023.
//

import UIKit

class EditProfileViewController: UIViewController {
    enum SettingType: String, CaseIterable {
        case firstname = "Имя"
        case secondName = "Фамилия"
        case birthday = "Дата рождения"
        case city = "Родной город"
        case profeccion = "Профессия"
        case save = ""
    }
    
    public lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(EditProfileViewCell.self, forCellReuseIdentifier: EditProfileViewCell.identifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = .clear
        tableView.rowHeight = 40
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.sectionHeaderHeight = 40
        tableView.estimatedSectionHeaderHeight = UITableView.automaticDimension
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    deinit {
        unsubscribeFromKeyBoardNotifications()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeFromKeyBoardNotifications()
    }
    
    private func unsubscribeFromKeyBoardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func subscribeFromKeyBoardNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.didShowKeyboard(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.didHideKeyboard(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    private func setupView() {
        createNavigationController(isHidden: false)
        title = "Основная информация"
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc private func didShowKeyboard(_ notification: Notification) {
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSValue,
        let endFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
        let curveOption = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else {return}
        
        UIView.animate(withDuration: duration as! TimeInterval, delay: 0, options: [.beginFromCurrentState, .init(rawValue: curveOption)]) {
            let edgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: endFrame.height, right: 0)
            self.tableView.contentInset = edgeInsets
            self.tableView.scrollIndicatorInsets = edgeInsets
        }
    }
    
    @objc private func didHideKeyboard(_ notification: Notification) {
        guard let duration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue,
        let curveOption = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else {return}
        
        UIView.animate(withDuration: duration , delay: 0, options: [.beginFromCurrentState, .init(rawValue: curveOption)]) {
            let edgeInsets = UIEdgeInsets.zero
            self.tableView.contentInset = edgeInsets
            self.tableView.scrollIndicatorInsets = edgeInsets
        }
    }
}

extension EditProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return SettingType.allCases.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EditProfileViewCell.identifier, for: indexPath) as? EditProfileViewCell else {return UITableViewCell(frame: .zero)}
        cell.clipsToBounds = true
        cell.layer.cornerRadius = 5

        switch indexPath.section {
        case 0:
            cell.textField.placeholder = "Введите имя"
            cell.textField.inputView = nil
            cell.textField.inputAccessoryView = nil
            cell.textField.tag = indexPath.section
        case 1:
            cell.textField.placeholder = "Введите фамилию"
            cell.textField.inputView = nil
            cell.textField.inputAccessoryView = nil
            cell.textField.tag = indexPath.section
        case 2:
            cell.textField.placeholder = "01.12.1998"
            cell.textField.tag = indexPath.section
        case 3:
            cell.textField.placeholder = "Введите родной город"
            cell.textField.inputView = nil
            cell.textField.inputAccessoryView = nil
            cell.textField.tag = indexPath.section
        case 4:
            cell.textField.placeholder = "Введите профессию"
            cell.textField.inputView = nil
            cell.textField.inputAccessoryView = nil
            cell.textField.tag = indexPath.section
        case 5:
            cell.backgroundColor = .clear
            cell.contentView.backgroundColor = .clear
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.layer.borderWidth = 1
            cell.textLabel?.layer.borderColor = UIColor.black.cgColor
            cell.textLabel?.layer.cornerRadius = 5
            cell.textLabel?.text = "Сохранить"
            cell.textField.isHidden = true
        default:
            break
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("SECTION \(indexPath.section) - ROW \(indexPath.row)")
        if indexPath.section == 5 {
            dismiss(animated: true, completion: nil)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
        case 0:
            return SettingType.allCases[0].rawValue
        case 1:
            return SettingType.allCases[1].rawValue
        case 2:
            return SettingType.allCases[2].rawValue
        case 3:
            return SettingType.allCases[3].rawValue
        case 4:
            return SettingType.allCases[4].rawValue
        case 5:
            return SettingType.allCases[5].rawValue
        default:
            fatalError()
        }
    }
}
