//
//  FavoriteViewController.swift
//  FinalDiplomNetology
//
//  Created by Shalopay on 30.01.2023.
//

import UIKit

class FavoriteViewController: UIViewController {
    var coreDataManager = CoreDataManager.shared
    
    public lazy var favoriteTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 200
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
        favoriteTableView.reloadData()
    }
    
    private func setupView() {
        createNavigationController(isHidden: false)
        navigationController?.navigationBar.prefersLargeTitles = false
        title = "Избранные посты"
        view.addSubview(favoriteTableView)
        NSLayoutConstraint.activate([
            favoriteTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            favoriteTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            favoriteTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            favoriteTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
extension FavoriteViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CurrentUser?.favoritesPost?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as? PostTableViewCell else {return UITableViewCell(frame: .zero)}
        if let post = CurrentUser?.favoritesPost?.allObjects[indexPath.row] as? Post {
            cell.setupCell(post: post)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            switch editingStyle {
            case .delete:
                if let post = CurrentUser?.favoritesPost?.allObjects[indexPath.row] as? Post {
                    CurrentUser?.removeFromFavoritesPost(post)
                    coreDataManager.saveContext()
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                }
            @unknown default:
                break
            }
    }
    
}
