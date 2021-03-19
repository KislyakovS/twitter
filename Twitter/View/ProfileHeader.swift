//
//  ProfileHeader.swift
//  Twitter
//
//  Created by Александр Кисляков on 17.03.2021.
//

import UIKit

protocol ProfileHeaderDelegate: class {
    func didTapBackButton()
}

class ProfileHeader: UICollectionReusableView {
    
    // MARK: - Property
    
    static let identifier = "ProfileHeader"
    
    weak var delegate: ProfileHeaderDelegate?
    
    private let filterBar = ProfileFilterView()
    
    let optionsCount = CGFloat(Int(ProfileFilterOptions.allCases.count))
    
    var user: User? {
        didSet {
            configure()
        }
    }
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .twitterBlue
                
        view.addSubview(backButton)
        backButton.anchor(top: view.topAnchor, left: view.leftAnchor, paddingTop: 42, paddingLeft: 16)
        backButton.setDimensions(width: 30, height: 30)
        
        return view
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "baseline_arrow_back_white_24dp")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        return button
    }()
    
    private let profileImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.borderColor = UIColor.white.cgColor
        image.layer.borderWidth = 4
        image.backgroundColor = .twitterBlue
        
        image.setDimensions(width: 80, height: 80)
        image.layer.cornerRadius = 80/2
        
        return image
    }()
    
    private lazy var actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.borderColor = UIColor.twitterBlue.cgColor
        button.layer.borderWidth = 1.25
        button.setTitleColor(.twitterBlue, for: .normal)
        button.setTitle("Loading", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        return button
    }()
    
    private let fullnameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "Eddie Brock"
        return label
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .lightGray
        label.text = "@venom"
        return label
    }()
    
    private let bioLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 3
        label.text = "This is a user bio that will span more than one line for test purposes"
        return label
    }()
    
    private let underlineView: UIView = {
        let view = UIView()
        view.backgroundColor = .twitterBlue
        return view
    }()
    
    private let followingLabel: UILabel = {
        let label = UILabel()
        
        let followTap = UITapGestureRecognizer(target: self, action: #selector(didTapFollowing))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(followTap)
        
        return label
    }()
    
    private let followersLabel: UILabel = {
        let label = UILabel()
        
        let followTap = UITapGestureRecognizer(target: self, action: #selector(didTapFollowers))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(followTap)
        
        return label
    }()
    
    // MARK:  - Lifeycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Did
    
    @objc private func didTapBackButton() {
        delegate?.didTapBackButton()
    }
    
    @objc private func didTapFollowing() {
        
    }
    
    @objc private func didTapFollowers() {
        
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        backgroundColor = .white
        
        addSubview(containerView)
        containerView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, height: 100)
        
        addSubview(profileImage)
        profileImage.anchor(top: containerView.safeAreaLayoutGuide.bottomAnchor, left: safeAreaLayoutGuide.leftAnchor,
                            paddingTop: -25, paddingLeft: 8)
        
        addSubview(actionButton)
        actionButton.anchor(top: containerView.safeAreaLayoutGuide.bottomAnchor, right: safeAreaLayoutGuide.rightAnchor,
                                    paddingTop: 12, paddingRight: 12, width: 120, height: 30)
        actionButton.layer.cornerRadius = 30/2
        
        let stack = UIStackView(arrangedSubviews: [fullnameLabel, usernameLabel, bioLabel])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 4
        
        addSubview(stack)
        stack.anchor(top: profileImage.safeAreaLayoutGuide.bottomAnchor,
                     left: safeAreaLayoutGuide.leftAnchor,
                     right: safeAreaLayoutGuide.rightAnchor,
                     paddingTop: 8,
                     paddingLeft: 12,
                     paddingRight: 12)
                
        let followStack = UIStackView(arrangedSubviews: [followingLabel, followersLabel])
        followStack.axis = .horizontal
        followStack.distribution = .fillEqually
        followStack.spacing = 8
        
        addSubview(followStack)
        followStack.anchor(top: stack.bottomAnchor,
                           left: leftAnchor,
                           paddingTop: 8,
                           paddingLeft: 12)
        
        addSubview(filterBar)
        filterBar.delegate = self
        filterBar.anchor(left: safeAreaLayoutGuide.leftAnchor,
                         bottom: safeAreaLayoutGuide.bottomAnchor,
                         right: safeAreaLayoutGuide.rightAnchor,
                         height: 50)
        
        addSubview(underlineView)
        underlineView.anchor(left: safeAreaLayoutGuide.leftAnchor,
                             bottom: safeAreaLayoutGuide.bottomAnchor,
                             width: frame.width/optionsCount,
                             height: 2)
    }
    
    private func configure() {
        guard let user = user else { return }
        
        let viewModel = ProfileHeaderViewModel(user: user)
        
        profileImage.sd_setImage(with: user.profileImageUrl, completed: nil)
        fullnameLabel.text = user.fullname
        usernameLabel.text = viewModel.username
        
        actionButton.setTitle(viewModel.actionButtonTitle, for: .normal)
        
        followersLabel.attributedText = viewModel.followersText
        followingLabel.attributedText = viewModel.followingText
    }
}


// MARK: - ProfileFilterViewDelegate

extension ProfileHeader: ProfileFilterViewDelegate {
    func filterView(_ view: ProfileFilterView, didSelect indexPath: IndexPath) {
        guard let cell = view.collectionView.cellForItem(at: indexPath) else { return }
        
        let xPosition = cell.frame.origin.x
        UIView.animate(withDuration: 0.3) {
            self.underlineView.frame.origin.x = xPosition
        }
    }
    
    
}
