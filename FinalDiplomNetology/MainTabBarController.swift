//
//  MainTabBarController.swift
//  FinalDiplomNetology
//
//  Created by Shalopay on 30.01.2023.
//

import UIKit

class MainTabBarController: UITabBarController {
    var user: User?
    private enum TabBarItem: Int {
        case main
        case profile
        case favotite
        var title: String {
            switch self {
            case .main:
                return "Главная"
            case .profile:
                return "Профиль"
            case .favotite:
                return "Сохраненные"
            }
        }
        var iconName: String {
            switch self {
            case .main:
                return "house"
            case .profile:
                return "person.crop.circle"
            case .favotite:
                return "heart"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    private func setupView(){
        UITabBar.appearance().tintColor = UIColor(hexRGB: ColorType.LabelTextColor.textOrangeColor.rawValue)
        view.backgroundColor = .white
        let dataSource: [TabBarItem] = [.main, .profile, .favotite]
        self.viewControllers = dataSource.map {
            switch $0 {
            case .main:
                let mainVC = MainViewController()
                return self.wrappedInNavigationController(with: mainVC, title: $0.title)
            case .profile:
                let profileVC = ContainerViewController()
                return self.wrappedInNavigationController(with: profileVC, title: $0.title)
            case .favotite:
            let favoriteVC = FavoriteViewController()
            return self.wrappedInNavigationController(with: favoriteVC, title: $0.title)
            }
        }
        self.viewControllers?.enumerated().forEach {
            $1.tabBarItem.title = dataSource[$0].title
            $1.tabBarItem.image = UIImage(systemName: dataSource[$0].iconName)
            $1.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: .zero, bottom: -5, right: .zero)
        }
    }
    
    private func wrappedInNavigationController(with: UIViewController, title: Any?) -> UINavigationController {
            return UINavigationController(rootViewController: with)
        }
    
}
