//
//  TweetHeader.swift
//  Twitter
//
//  Created by Александр Кисляков on 20.03.2021.
//

import UIKit
import ActiveLabel

protocol TweetHeaderDelegate: class {
    func showActionSheet()
}

class TweetHeader: UICollectionReusableView {
    
    // MARK: - Properties
    
    var tweet: Tweet? {
        didSet {
            configure()
        }
    }
    
    weak var delegate: TweetHeaderDelegate?
    
    static let identifier = "TweetHeader"
    
    private lazy var profileImage: UIImageView = {
       let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.setDimensions(width: 48, height: 48)
        image.layer.cornerRadius = 48/2
        image.backgroundColor = .twitterBlue
        return image
    }()
    
    private let fullnameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    private let usernameLabel: ActiveLabel = {
        let label = ActiveLabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.mentionColor = .lightGray
        return label
    }()
    
    private let captionLabel: ActiveLabel = {
        let label = ActiveLabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
        label.mentionColor = .twitterBlue
        label.hashtagColor = .twitterBlue
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var optionsButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .lightGray
        button.setImage(UIImage(named: "down_arrow_24pt"), for: .normal)
        button.addTarget(self, action: #selector(didTapActionSheet), for: .touchUpInside)
        return button
    }()
    
    private let retweetsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let likesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var statsView: UIView = {
        let view = UIView()
        
        let divider1 = UIView()
        divider1.backgroundColor = .systemGroupedBackground
        view.addSubview(divider1)
        divider1.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                        left: view.safeAreaLayoutGuide.leftAnchor,
                        right: view.safeAreaLayoutGuide.rightAnchor,
                        paddingLeft: 8, height: 1)
        
        let stack = UIStackView(arrangedSubviews: [retweetsLabel, likesLabel])
        stack.axis = .horizontal
        stack.spacing = 12
        
        view.addSubview(stack)
        stack.centerY(inView: view)
        stack.anchor(left: view.safeAreaLayoutGuide.leftAnchor, paddingLeft: 8)
        
        let divider2 = UIView()
        divider2.backgroundColor = .systemGroupedBackground
        view.addSubview(divider2)
        divider2.anchor(left: view.safeAreaLayoutGuide.leftAnchor,
                        bottom: view.safeAreaLayoutGuide.bottomAnchor,
                        right: view.safeAreaLayoutGuide.rightAnchor,
                        paddingLeft: 8, height: 1)
        
        return view
    }()
    
    private lazy var commentButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "comment"), for: .normal)
        button.tintColor = .darkGray
        button.setDimensions(width: 20, height: 20)
        return button
    }()
    
    private lazy var retweetButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "retweet"), for: .normal)
        button.tintColor = .darkGray
        button.setDimensions(width: 20, height: 20)
        return button
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "like"), for: .normal)
        button.tintColor = .darkGray
        button.setDimensions(width: 20, height: 20)
        return button
    }()
    
    private lazy var shareButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "share"), for: .normal)
        button.tintColor = .darkGray
        button.setDimensions(width: 20, height: 20)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Did
    
    @objc private func didTapActionSheet() {
        delegate?.showActionSheet()
    }
    
    // MARK: - Helpers

    private func configureUI() {
        backgroundColor = .white
        
        addSubview(profileImage)
        profileImage.anchor(top: safeAreaLayoutGuide.topAnchor, left: safeAreaLayoutGuide.leftAnchor,
                            paddingTop: 8, paddingLeft: 8)
        
        let nameStack = UIStackView(arrangedSubviews: [fullnameLabel, usernameLabel])
        nameStack.axis = .vertical
        nameStack.distribution = .fillProportionally
        nameStack.spacing = 2
        
        addSubview(nameStack)
        nameStack.anchor(top: safeAreaLayoutGuide.topAnchor, left: profileImage.safeAreaLayoutGuide.rightAnchor,
                         paddingTop: 10, paddingLeft: 8)
        
        addSubview(captionLabel)
        captionLabel.anchor(top: profileImage.safeAreaLayoutGuide.bottomAnchor,
                            left: safeAreaLayoutGuide.leftAnchor,
                            right: safeAreaLayoutGuide.rightAnchor,
                            paddingTop: 20, paddingLeft: 8, paddingRight: 8)
        
        addSubview(dateLabel)
        dateLabel.anchor(top: captionLabel.safeAreaLayoutGuide.bottomAnchor,
                         left: safeAreaLayoutGuide.leftAnchor,
                         paddingTop: 20, paddingLeft: 8)
        
        addSubview(optionsButton)
        optionsButton.centerY(inView: nameStack)
        optionsButton.anchor(right: safeAreaLayoutGuide.rightAnchor, paddingRight: 8)
        
        addSubview(statsView)
        statsView.anchor(top: dateLabel.safeAreaLayoutGuide.bottomAnchor,
                         left: safeAreaLayoutGuide.leftAnchor,
                         right: safeAreaLayoutGuide.rightAnchor,
                         paddingTop: 20, height: 40)
        
        let stackButtons = UIStackView(arrangedSubviews: [commentButton, retweetButton, likeButton, shareButton])
        stackButtons.axis = .horizontal
        stackButtons.spacing = 72
        
        addSubview(stackButtons)
        stackButtons.centerX(inView: self)
        stackButtons.anchor(bottom: safeAreaLayoutGuide.bottomAnchor, paddingBottom: 10)
    }
    
    private func configure() {
        guard let tweet = tweet else { return }
        let viewModel = TweetViewModel(tweet: tweet)
        
        profileImage.sd_setImage(with: viewModel.profileImageUrl, completed: nil)
        dateLabel.text = viewModel.headerTimestamp
        fullnameLabel.text = tweet.user.fullname
        retweetsLabel.attributedText = viewModel.retweetsString
        likesLabel.attributedText = viewModel.likesString
        usernameLabel.text = viewModel.username
        captionLabel.text = tweet.caption
    }
}
