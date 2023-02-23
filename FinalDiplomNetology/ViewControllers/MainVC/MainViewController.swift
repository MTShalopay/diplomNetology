//
//  MainViewController.swift
//  FinalDiplomNetology
//
//  Created by Shalopay on 28.01.2023.
//

import UIKit
import CoreData

class MainViewController: UIViewController {
    var coreDataManager = CoreDataManager.shared
    var user: User?
    enum menuItem: String, CaseIterable {
        case news = "Новости"
        case foryou = "Для вас"
    }
    private lazy var fetchResultController: NSFetchedResultsController<NSFetchRequestResult> = {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        let sortDescription = NSSortDescriptor(key: "numberPhone", ascending: true)
        fetchRequest.sortDescriptors = [sortDescription]
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: coreDataManager.context, sectionNameKeyPath: nil, cacheName: nil)
        //frc.delegate = self
        return frc
    }()

    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    private lazy var itemCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MenuViewCell.self, forCellWithReuseIdentifier: MenuViewCell.identifier)
        collectionView.backgroundColor = UIColor(hexRGB: ColorType.ViewColor.backGroundColorView.rawValue)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    public lazy var mainTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 24
        tableView.register(MainHeaderView.self, forHeaderFooterViewReuseIdentifier: MainHeaderView.identifier)
        tableView.register(StoriesViewCell.self, forCellReuseIdentifier: StoriesViewCell.identifier)
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "default")
        tableView.showsVerticalScrollIndicator = false
        tableView.alwaysBounceVertical = false
        tableView.backgroundColor = UIColor(hexRGB: ColorType.ViewColor.backGroundColorView.rawValue)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
//        do {
//            try fetchResultController.performFetch()
//        } catch let error {
//            print(error)
//        }
//        for object in fetchResultController.fetchedObjects as! [User] {
//            if object.uuID == CurrentUser?.uuID {
//                print("ZZZ: \(object.uuID) \(object.numberPhone) \(object.password) \(object.firstName) \(object.dayBirth)")
//            }
//            print("================")
//        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
    }
    
    private func setupView() {
        createNavigationController(isHidden: false)
        navigationController?.navigationBar.prefersLargeTitles = false
        title = "Главная"
        let searchBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .done, target: self, action: #selector(searchAction))
        let notifyBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "bell.fill"), style: .done, target: self, action: #selector(notifyAction))
        navigationItem.rightBarButtonItems = [notifyBarButtonItem, searchBarButtonItem]
        
        view.addSubviews([
            itemCollectionView, mainTableView
        ])
        NSLayoutConstraint.activate([
            itemCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            itemCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            itemCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            itemCollectionView.heightAnchor.constraint(equalToConstant: 30),
            
            mainTableView.topAnchor.constraint(equalTo: itemCollectionView.bottomAnchor, constant: 10),
            mainTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mainTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mainTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    @objc private func searchAction() {
        let searchVC = SearchViewController()
        navigationController?.pushViewController(searchVC, animated: true)
    }
    @objc private func notifyAction() {
        print(#function)
    }
}
extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        menuItem.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuViewCell.identifier, for: indexPath) as? MenuViewCell else {return UICollectionViewCell(frame: .zero)}
        let item = menuItem.allCases[indexPath.row].rawValue
        cell.setupCell(item: item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("section \(indexPath.section) - item \(indexPath.row)")
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print(#function)
        let cell = collectionView.cellForItem(at: indexPath) as? MenuViewCell
        return CGSize(width: 74, height: 22)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 5
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: StoriesViewCell.identifier, for: indexPath) as? StoriesViewCell else { return UITableViewCell(frame: .zero)}
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as? PostTableViewCell else { return UITableViewCell(frame: .zero) }
            return cell
        default:
            return UITableViewCell(frame: .zero)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("SECTION \(indexPath.section) - ROW \(indexPath.row)")
        let profileSubscriber = ProfileViewController()
        profileSubscriber.navigationItem.leftItemsSupplementBackButton = true
        guard let profileHeaderView = profileSubscriber.tableView(profileSubscriber.profileTableView, viewForHeaderInSection: 0) as? ProfileHeaderView else {return}
            profileHeaderView.editButton.isHidden = true
            profileHeaderView.subscribersButtonStack.isHidden = false
            
            guard let searchNoteHeaderView = profileSubscriber.tableView(profileSubscriber.profileTableView, viewForHeaderInSection: 1) as? SearchNoteHeaderView else {return }
            searchNoteHeaderView.searchButton.isHidden = true
            searchNoteHeaderView.titleLabel.text = "Посты Максима"
            
            let settingBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis"), style: .done, target: self, action: #selector(self.menuTap))
            settingBarButtonItem.tintColor = UIColor(hexRGB: ColorType.LabelTextColor.textOrangeColor.rawValue)
            profileSubscriber.navigationItem.rightBarButtonItem = settingBarButtonItem
        
        navigationController?.pushViewController(profileSubscriber, animated: true)
    }
    
    @objc private func menuTap() {
        print(#function)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0
        case 1:
            return UITableView.automaticDimension
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
         switch section {
         case 1:
             guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: MainHeaderView.identifier) as? MainHeaderView else { return nil }
            return header
         default:
             return nil
         }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
            return UIView()
    }
}

extension MainViewController: NSFetchedResultsControllerDelegate {

    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        mainTableView.beginUpdates()
    }
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            print("INSERT:")
//            if let indexPath = indexPath {
//                profileTableView.insertRows(at: [indexPath], with: .automatic)
//            }
        case .delete:
            print("DELETE:")
//            if let indexPath = indexPath {
//                profileTableView.deleteRows(at: [indexPath], with: .automatic)
//            }
        case .move:
            print("MOVE:")
//            if let indexPath = indexPath {
//                profileTableView.deleteRows(at: [indexPath], with: .automatic)
//            }
//            if let indexPath = newIndexPath {
//                profileTableView.insertRows(at: [indexPath], with: .automatic)
//            }
        case .update:
            print("UPDATE:")
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
        @unknown default:
            break
        }
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        mainTableView.endUpdates()
    }
}


