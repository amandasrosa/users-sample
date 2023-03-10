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
    private var genericError = "Failed to load data. Please try later"
    
    // MARK: - UI

    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.separatorStyle = .none
        table.register(UsersInfoViewCell.self, forCellReuseIdentifier: "cell")
        table.isHidden = true
        return table
    }()
    
    private lazy var loadingView: UIActivityIndicatorView = {
        let loading = UIActivityIndicatorView()
        loading.translatesAutoresizingMaskIntoConstraints = false
        loading.hidesWhenStopped = true
        return loading
    }()
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = label.font.withSize(16)
        label.numberOfLines = .zero
        label.lineBreakMode = .byWordWrapping
        label.isHidden = true
        label.text = genericError
        return label
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
        loadingView.startAnimating()
    }
    
    private func setupConstraints() {
        view.addSubview(tableView)
        view.addSubview(loadingView)
        view.addSubview(errorLabel)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 24),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -48),
            
            loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
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
        if usersData.isEmpty {
            DispatchQueue.main.async {
                self.loadingView.stopAnimating()
                self.errorLabel.isHidden = false
            }
        } else {
            let uniqueUsers = Set(usersData)
            let sortedUsers = uniqueUsers.sorted { $0.profile.firstName < $1.profile.firstName }
            users = Array(sortedUsers)
            DispatchQueue.main.async {
                self.errorLabel.isHidden = true
                self.tableView.isHidden = false
                self.tableView.reloadData()
                self.loadingView.stopAnimating()
            }
        }
    }
}
