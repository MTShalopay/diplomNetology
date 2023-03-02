//
//  SubscriptionViewController.swift
//  FinalDiplomNetology
//
//  Created by Shalopay on 16.02.2023.
//

import UIKit
import CoreData

class SubscriptionViewController: UIViewController {
    var coreDataManager = CoreDataManager.shared
    private let segmenItems = ["Подписчики","Подписки"]
    private var followers = [User]()
    private var subscriptions = [User]()
    
    public lazy var subscriptionSegmentControl: UISegmentedControl = {
       let segmentedControl = UISegmentedControl(items: segmenItems)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(updateTableView), for: .valueChanged)
        segmentedControl.selectedSegmentTintColor = UIColor(hexRGB: ColorType.LabelTextColor.textOrangeColor.rawValue)
        segmentedControl.backgroundColor = UIColor(hexRGB: ColorType.ViewColor.backGroundColorView.rawValue)
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(hexRGB: ColorType.LabelTextColor.textWhiteColor.rawValue)]
        segmentedControl.setTitleTextAttributes(titleTextAttributes as [NSAttributedString.Key : Any], for: .normal)
        segmentedControl.setTitleTextAttributes(titleTextAttributes as [NSAttributedString.Key : Any], for: .selected)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()
    
    private lazy var searchController: UISearchController = {
    let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.definesPresentationContext = true
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск"
        return searchController
    }()
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    private lazy var subscriptTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 24
        tableView.register(SearchViewCell.self, forCellReuseIdentifier: SearchViewCell.identifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "default")
        tableView.showsVerticalScrollIndicator = false
        tableView.alwaysBounceVertical = false
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
        followers = CurrentUser?.followers?.allObjects as! [User]
        subscriptions = CurrentUser?.subscriptions?.allObjects as! [User]
        subscriptTableView.reloadData()
    }
    
    private func setupView() {
        subscriptTableView.tableHeaderView = searchController.searchBar
        view.backgroundColor = UIColor(hexRGB: ColorType.ViewColor.backGroundColorView.rawValue)
        view.addSubviews([
            subscriptTableView, subscriptionSegmentControl
        ])
        NSLayoutConstraint.activate([
            subscriptionSegmentControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            subscriptionSegmentControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            subscriptionSegmentControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            subscriptionSegmentControl.heightAnchor.constraint(equalToConstant: 44),
            
            subscriptTableView.topAnchor.constraint(equalTo: subscriptionSegmentControl.bottomAnchor),
            subscriptTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            subscriptTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            subscriptTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    @objc private func updateTableView() {
        subscriptTableView.reloadData()
    }
}

extension SubscriptionViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var returnValue = 0
        switch subscriptionSegmentControl.selectedSegmentIndex {
        case 0:
            returnValue = followers.count
            break
        case 1:
            returnValue = subscriptions.count
            break
        default:
            break
        }
        return returnValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchViewCell.identifier, for: indexPath) as? SearchViewCell else { return UITableViewCell(frame: .zero)}
        switch subscriptionSegmentControl.selectedSegmentIndex {
        case 0:
            //подписчики
            let follower = followers[indexPath.row]
            cell.setupCell(user: follower)
            break
        case 1:
            //подписки
            let subscription = subscriptions[indexPath.row]
            cell.setupCell(user: subscription)
            break
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let profileSubscriber = ProfileViewController()
        profileSubscriber.navigationItem.leftItemsSupplementBackButton = true
        switch subscriptionSegmentControl.selectedSegmentIndex {
            case 0:
                let follower = followers[indexPath.row]
                profileSubscriber.user = follower
            case 1:
                let subscription = subscriptions[indexPath.row]
                profileSubscriber.user = subscription
            default:
                break
        }
        navigationController?.pushViewController(profileSubscriber, animated: true)
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        switch editingStyle {
        case .delete:
            switch subscriptionSegmentControl.selectedSegmentIndex {
            case 0:
                if let follower = CurrentUser?.followers?.allObjects[indexPath.row] as? User {
                    CurrentUser?.removeFromSubscriptions(follower)
                    followers.remove(at: indexPath.row)
                    coreDataManager.saveContext()
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                }
            case 1:
                if let subscription = CurrentUser?.subscriptions?.allObjects[indexPath.row] as? User {
                    CurrentUser?.removeFromSubscriptions(subscription)
                    subscriptions.remove(at: indexPath.row)
                    coreDataManager.saveContext()
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                }
            default:
                break
            }
        @unknown default:
            break
        }
    }
}

extension SubscriptionViewController: UISearchResultsUpdating, UISearchControllerDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
//        filteredUser = users.filter({ (user: User) -> Bool in
//            return user.firstName?.lowercased().contains(searchText.lowercased()) ?? false //restaurant.name.lowercased().contains(searchText.lowercased())
//        })
        subscriptTableView.reloadData()
    }
}
