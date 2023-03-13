//
//  UsersUseCase.swift
//  UsersACServices
//
//  Created by Amanda Rosa on 2023-03-08.
//

import Foundation
import UsersACDomain

public class UsersUseCase {
    
    public let networkingOperation: NetworkingOperation
    
    public init (networkingOperation: NetworkingOperation) {
        self.networkingOperation = networkingOperation
    }
    
    public func requestUsers(url: URL, completion: @escaping ([User]) -> Void) {
        networkingOperation.request(url: url, expecting: [User].self) { result in
            switch result {
            case .success(let users):
                completion(users)
            case .failure(_):
                completion([])
            }
        }

    }
}
