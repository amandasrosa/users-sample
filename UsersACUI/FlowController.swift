//
//  FlowController.swift
//  UsersAC
//
//  Created by Amanda Rosa on 2023-03-07.
//

import UIKit
import UsersACServices

public class FlowController: UIViewController {
    
    private let navController = UINavigationController()

    private func startHome() {
        let vc = HomeViewController()
        vc.delegate = self
        
        addNavigationController(navController)
        navController.pushViewController(vc, animated: true)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        startHome()
    }
    
    func addNavigationController(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
}

extension FlowController: HomeViewControllerDelegate {
    public func callUsersScreen(url: URL) {
        let usersUseCase = UsersUseCase(networkingOperation: NetworkingOperation.shared)
        navController.pushViewController(UsersViewController(viewModel: UsersViewModel(useCase: usersUseCase, url: url)), animated: true)
    }
}
