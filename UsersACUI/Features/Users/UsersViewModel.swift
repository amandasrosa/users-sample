//
//  UsersViewModel.swift
//  UsersAC
//
//  Created by Amanda Rosa on 2023-03-06.
//

import Foundation
import UsersACDomain
import UsersACServices

public protocol UsersViewModelDelegate: AnyObject {
    func updateUsers(with: [User])
}

public final class UsersViewModel {
    
    // MARK: - PRIVATE PROPERTIES
    
    private let useCase: UsersUseCase
    private var users = [User]()
    
    weak var delegate: UsersViewModelDelegate?
    
    // MARK: - INITIALIZERS
    
    init(useCase: UsersUseCase, url: URL) {
        self.useCase = useCase
        fetchUsers(url: url)
    }
    
    // MARK: - PUBLIC METHODS
    
    public func fetchUsers(url: URL) {
        useCase.requestUsers(url: url) { [weak self] usersData in
            guard let self = self else { return }
            self.users = usersData
            self.delegate?.updateUsers(with: self.users)
        }
    }
}
