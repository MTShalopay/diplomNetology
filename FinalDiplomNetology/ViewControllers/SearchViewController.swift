//
//  SearchViewController.swift
//  FinalDiplomNetology
//
//  Created by Shalopay on 16.02.2023.
//

import UIKit
import CoreData

class SearchViewController: UIViewController {
    private var filteredUser = [User]()
    var users = [User]()
    var coreDataManager = CoreDataManager.shared
    
    private lazy var searchController: UISearchController = {
    let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.definesPresentationContext = true
        searchController.searchBar.placeholder = "Кого ищем?"
        return searchController
    }()
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    private lazy var fetchResultController: NSFetchedResultsController<NSFetchRequestResult> = {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        let sortDescription = NSSortDescriptor(key: "firstName", ascending: true)
        fetchRequest.sortDescriptors = [sortDescription]
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: coreDataManager.context, sectionNameKeyPath: nil, cacheName: nil)
        return frc
    }()
    
    public lazy var searchTableView: UITableView = {
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
        setupView()
        do {
            try fetchResultController.performFetch()
        } catch let error {
            print("ERROR searchViewController: \(error)")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        users = fetchResultController.fetchedObjects as! [User]
    }
    private func setupView() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        view.backgroundColor = UIColor(hexRGB: ColorType.ViewColor.backGroundColorView.rawValue)
        view.addSubviews([ searchTableView
        ])
        NSLayoutConstraint.activate([
            searchTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            searchTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            searchTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension SearchViewController: UISearchResultsUpdating, UISearchControllerDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        print(#function)
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filteredUser = users.filter({ (user: User) -> Bool in
            return user.firstName?.lowercased().contains(searchText.lowercased()) ?? false //restaurant.name.lowercased().contains(searchText.lowercased())
        })
        searchTableView.reloadData()
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if isFiltering {
//                return filteredUser.count
//            }
//            return users.count
        filteredUser.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchViewCell.identifier, for: indexPath) as? SearchViewCell else { return UITableViewCell(frame: .zero)}
        let user = filteredUser[indexPath.row]
        
//        var user: User
//
//        if isFiltering {
//            user = filteredUser[indexPath.row]
//        } else {
//            user = users[indexPath.row]
//        }
        
        cell.setupCell(user: user)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = filteredUser[indexPath.row]
        let profileSubscriber = ProfileViewController()
        profileSubscriber.navigationItem.leftItemsSupplementBackButton = true
            profileSubscriber.user = user
        navigationController?.pushViewController(profileSubscriber, animated: true)
    }
}
