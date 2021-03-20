//
//  UserCell.swift
//  Twitter
//
//  Created by Александр Кисляков on 19.03.2021.
//

import UIKit

class UserCell: UITableViewCell {
    
    // MARK: - Propertes
    
    static let identifer = "UserCell"
    
    var user: User? {
        didSet {
            configure()
        }
    }
    
    private lazy var profileImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.setDimensions(width: 48, height: 48)
        image.layer.cornerRadius = 48/2
        image.backgroundColor = .twitterBlue
        return image
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 1
        label.text = "Hello world"
        return label
    }()
    
    private let fullnameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 1
        label.text = "Hello world"
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not  been implemented")
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        addSubview(profileImageView)
        profileImageView.centerY(inView: self, leftAnchor: safeAreaLayoutGuide.leftAnchor, paddingLeft: 12)
        
        let stack = UIStackView(arrangedSubviews: [usernameLabel, fullnameLabel])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 2
        
        addSubview(stack)
        stack.centerY(inView: self,
                      leftAnchor: profileImageView.safeAreaLayoutGuide.rightAnchor,
                      paddingLeft: 8)
    }
    
    private func configure() {
        guard let user = user else { return }
        
        profileImageView.sd_setImage(with: user.profileImageUrl, completed: nil)
        usernameLabel.text = user.username
        fullnameLabel.text = user.fullname
    }
}
