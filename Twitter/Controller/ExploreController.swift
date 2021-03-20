//
//  ExploreController.swift
//  Twitter
//
//  Created by Александр Кисляков on 10.03.2021.
//

import UIKit

class ExploreController: UITableViewController {

    // MARK: - Properties
    
    private var users = [User]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    private var filterUsers = [User]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var isSearch: Bool {
        return searchController.isActive && !searchController.searchBar.text!.isEmpty
    }
        
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        configureViewController()
        fetchUsers()
        configureSearchConroller()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - API
    
    private func fetchUsers() {
        UserService.shared.fetchUsers { users in
            self.users = users
        }
    }
    
    // MARK: - Helpers
    
    private func configureViewController() {
        view.backgroundColor = .white
        
        navigationItem.title = "Explore"
        
        tableView.register(UserCell.self, forCellReuseIdentifier: UserCell.identifer)
        tableView.rowHeight = 60
        tableView.separatorStyle = .none
    }
    
    private func configureSearchConroller() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search..."
        navigationItem.searchController = searchController
        definesPresentationContext = false
    }
}

extension ExploreController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearch ? filterUsers.count : users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.identifer, for: indexPath) as! UserCell
        let user = isSearch ? filterUsers[indexPath.row] : users[indexPath.row]
        cell.user = user
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = isSearch ? filterUsers[indexPath.row] : users[indexPath.row]
        let conroller = ProfileController(user: user)
        navigationController?.pushViewController(conroller, animated: true)
    }
}

// MARK: - UISearchResultsUpdating

extension ExploreController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let search = searchController.searchBar.text?.lowercased() else { return }
        
        filterUsers = users.filter { user in
            let fullname = user.fullname.lowercased()
            let username = user.username.lowercased()
            if fullname.range(of: search) != nil || username.range(of: search) != nil {
                return true
            }
            
            return false
        }
    }
}
