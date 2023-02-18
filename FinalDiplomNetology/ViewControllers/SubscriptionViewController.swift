//
//  SubscriptionViewController.swift
//  FinalDiplomNetology
//
//  Created by Shalopay on 16.02.2023.
//

import UIKit

class SubscriptionViewController: UIViewController {
    
    private let segmenItems = ["Подписчики","Подписки"]
    private lazy var subscriptionSegmentControl: UISegmentedControl = {
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
    
    private let leftArray = ["0","0","0","0","0","0","0","0"]
    private let rightArray = ["1","1","1","1","1","1","1","1"]
    
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
        setupView()
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
            returnValue = leftArray.count
            break
        case 1:
            returnValue = rightArray.count
            break
        default:
            break
        }
        return returnValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchViewCell.identifier, for: indexPath) as? SearchViewCell else { return UITableViewCell(frame: .zero)}
//        switch subscriptionSegmentControl.selectedSegmentIndex {
//        case 0:
//            cell.textLabel?.text = leftArray[indexPath.row]
//            break
//        case 1:
//            cell.textLabel?.text = rightArray[indexPath.row]
//            break
//        default:
//            break
//        }
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
