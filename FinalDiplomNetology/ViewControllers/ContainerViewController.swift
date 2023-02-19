//
//  ContainerViewController.swift
//  FinalDiplomNetology
//
//  Created by Shalopay on 31.01.2023.
//

import UIKit

class ContainerViewController: UIViewController {
    enum SettingState {
        case open
        case close
    }
    private var settingState:  SettingState = .close
    
    let profileVC = ProfileViewController()
    let settingProfileVC = SettingProfileViewController()
    var navVC: UINavigationController?
    lazy var editProfileVC = EditProfileViewController()
    lazy var onBoardingVC = OnBoardingStart()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        addChild()
    }
    
    private func addChild() {
        profileVC.delegate = self
        let navVC = UINavigationController(rootViewController: profileVC)
        self.navigationController?.isNavigationBarHidden = true
        addChildVC(navVC)
        self.navVC = navVC
        
        settingProfileVC.delegate = self
        addChild(settingProfileVC)
        view.insertSubview(settingProfileVC.view, at: 0)
        settingProfileVC.didMove(toParent: self)
        
    }
}

extension ContainerViewController: ProfileViewControllerDelegate {
    func didTapButton() {
        toggleMenu(completed: nil)
    }
    
    func toggleMenu(completed: (()-> Void)?) {
        switch settingState {
        case .open:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.navVC?.view.frame.origin.x = 0
            } completion: { [weak self] (done) in
                if done { self?.settingState = .close }
            }
        case .close:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.navVC?.view.frame.origin.x = 100 - self.profileVC.view.frame.size.width
            } completion: { [weak self] (done) in
                if done { self?.settingState = .open }
            }
        }
    }
}

extension ContainerViewController: SettingProfileViewControllerDelegate {
    func didSelect(menuItem: SettingProfileViewController.SettingOption) {
        toggleMenu(completed: nil)
        switch menuItem {
        case .profile:
            resetToProfile()
        case .setting:
            addEditProfile()
        case .exit:
            let alertController = UIAlertController(title: "Выход из профиля", message: "Действительно хотите выйти?", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
            let okAction = UIAlertAction(title: "Да", style: .default) { _ in
                self.goToOnBoardVC()
            }
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            present(alertController, animated: true, completion: nil)
        }
    }
    
    private func addEditProfile() {
        let vc = editProfileVC
        //profileVC.addChild(vc)
        vc.user = profileVC.user
        vc.modalPresentationStyle = .fullScreen
        profileVC.present(vc, animated: true, completion: nil)
//        profileVC.view.addSubview(vc.view)
//        vc.view.frame = view.frame
//        vc.didMove(toParent: profileVC)
//        profileVC.title = vc.title
//        profileVC.profileIDLabel.isHidden = true
        
    }
    private func resetToProfile(){
        editProfileVC.removeChildVC()
        profileVC.title = " "
        profileVC.profileIDLabel.isHidden = false
    }
    private func goToOnBoardVC() {
        let vc = UINavigationController(rootViewController: onBoardingVC)
        vc.modalTransitionStyle = .flipHorizontal
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
}
