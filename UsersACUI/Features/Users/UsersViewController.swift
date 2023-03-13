//
//  UsersViewController.swift
//  UsersAC
//
//  Created by Amanda Rosa on 2023-03-06.
//

import UIKit
import UsersACDomain

public final class UsersViewController: UIViewController {
    
    // MARK: - PRIVATE PROPERTIES
    
    private var users = [User]()
    private let viewModel: UsersViewModel
    
    // MARK: - UI
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.separatorStyle = .none
        table.register(UsersInfoViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    // MARK: - INITIALIZERS
    
    init(viewModel: UsersViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error at init(coder:)")
    }

    // MARK: - PRIVATE METHODS
    
    private func setupUI() {
        view.backgroundColor = .white
    }
    
    private func setupConstraints() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 24),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -48)
        ])
    }
}

// MARK: - TABLE VIEW DATA SOURCE

extension UsersViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? UsersInfoViewCell
        guard let cell = cell else { return UITableViewCell() }
        cell.setup(user: users[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
}

// MARK: - USERS VIEW MODEL DELEGATE

extension UsersViewController: UsersViewModelDelegate {
    public func updateUsers(with usersData: [User]) {
        let uniqueUsers = Set(usersData)
        let sortedUsers = uniqueUsers.sorted { $0.profile.firstName < $1.profile.firstName }
        users = Array(sortedUsers)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
