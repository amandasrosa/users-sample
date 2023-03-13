//
//  HomeViewController.swift
//  UsersAC
//
//  Created by Amanda Rosa on 2023-03-06.
//

import UIKit

public protocol HomeViewControllerDelegate: AnyObject {
    func callUsersScreen(url: URL)
}

public final class HomeViewController: UIViewController {
    
    private var genericError = "Please enter a valid API"
    weak var delegate: HomeViewControllerDelegate?
    
    // MARK: - UI
    
    private lazy var contentStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
                                apiTextField,
                                nextButton,
                                errorLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 24
        stack.axis = .vertical
        return stack
    }()

    private lazy var apiTextField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 0, height: 40))
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.returnKeyType = UIReturnKeyType.done
        textField.placeholder = "Enter API here"
        return textField
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Next", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .red
        label.font = label.font.withSize(16)
        label.isHidden = true
        label.text = genericError
        return label
    }()
    
    // MARK: - INITIALIZERS
    
    public init() {
        super.init(nibName: nil, bundle: nil)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error at init(coder:)")
    }

    // MARK: - PRIVATE METHODS
    
    private func setupUI() {
        view.addSubview(contentStackView)
        view.backgroundColor = .white
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 48),
            contentStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -48),
            contentStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    // MARK: - ACTIONS
    
    @objc private func didTapNextButton() {
        if let urlString = apiTextField.text, !urlString.isEmpty,
           let url = URL(string: urlString) {
            errorLabel.isHidden = true
            delegate?.callUsersScreen(url: url)
        } else {
            errorLabel.isHidden = false
        }
    }
}
