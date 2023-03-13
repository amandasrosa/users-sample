//
//  UsersInfoViewCell.swift
//  UsersACUI
//
//  Created by Amanda Rosa on 2023-03-11.
//

import UIKit
import UsersACDomain

final class UsersInfoViewCell: UITableViewCell {
    
    // MARK: - UI
    
    private lazy var contentStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
                                userAvatarImageView,
                                userNameLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 16
        stack.alignment = .center
        return stack
    }()
    
    private lazy var userAvatarImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var userNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = .black
        return label
    }()
    
    override init (style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    
    // MARK: - INITIALIZERS
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - PRIVATE METHODS
    
    private func setupUI() {
        backgroundColor = .white
    }
    
    private func setupConstraints() {
        addSubview(contentStackView)
        NSLayoutConstraint.activate([
            userAvatarImageView.widthAnchor.constraint(equalToConstant: 80),
            userAvatarImageView.heightAnchor.constraint(equalToConstant: 80),
            contentStackView.topAnchor.constraint(equalTo: topAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    // MARK: - PUBLIC METHODS
    
    public func setup(user: User) {
        userNameLabel.text = "\(user.profile.firstName) \(user.profile.lastName)"
        userAvatarImageView.downloadImageFrom(user.avatar, contentMode: .scaleAspectFit)
    }
    
}
