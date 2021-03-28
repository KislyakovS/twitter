//
//  TweetCollectionViewCell.swift
//  Twitter
//
//  Created by Александр Кисляков on 16.03.2021.
//

import UIKit
import SDWebImage
import ActiveLabel

protocol TweetCollectionViewCellDelegate: class {
    func didTapProfile(_ user: User)
    func didTapComment(_ tweet: Tweet)
    func didTapLike(_ cell: TweetCell)
    func didFetchUser(withUsername username: String)
}

class TweetCell: UICollectionViewCell {
        
    // MARK: - Properties
    
    static let identifier = "tweetCell"
    
    weak var delegate: TweetCollectionViewCellDelegate?
    
    var tweet: Tweet? {
        didSet {
            configure()
        }
    }
    
    private lazy var profileImage: UIImageView = {
       let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.setDimensions(width: 48, height: 48)
        image.layer.cornerRadius = 48/2
        image.backgroundColor = .twitterBlue
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapProfile))
        image.addGestureRecognizer(tap)
        image.isUserInteractionEnabled = true
        
        return image
    }()
    
    private let captionLabel: ActiveLabel = {
        let label = ActiveLabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.mentionColor = .twitterBlue
        label.hashtagColor = .twitterBlue
        label.numberOfLines = 0
        return label
    }()
    
    private let infoLabel: ActiveLabel = {
        let label = ActiveLabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.mentionColor = .lightGray
        return label
    }()
    
    private let underlineView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGroupedBackground
        return view
    }()
    
    private lazy var commentButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "comment"), for: .normal)
        button.tintColor = .darkGray
        button.setDimensions(width: 20, height: 20)
        button.addTarget(self, action: #selector(didTapComment), for: .touchUpInside)
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
        button.addTarget(self, action: #selector(didTapLike), for: .touchUpInside)
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
        
        backgroundColor = .white
        
        configureUI()
        configureMention()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Did
    
    @objc private func didTapProfile() {
        guard let user = tweet?.user else { return }
        
        delegate?.didTapProfile(user)
    }
    
    @objc private func didTapComment() {
        guard let tweet = tweet else { return }
        
        delegate?.didTapComment(tweet)
    }
    
    @objc private func didTapLike() {        
        delegate?.didTapLike(self)
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        addSubview(profileImage)
        profileImage.anchor(top: safeAreaLayoutGuide.topAnchor,
                            left: safeAreaLayoutGuide.leftAnchor,
                            paddingTop: 8,
                            paddingLeft: 8)
        
        let stack = UIStackView(arrangedSubviews: [infoLabel, captionLabel])
        stack.axis = .vertical
        stack.spacing = 0
        
        addSubview(stack)
        stack.anchor(top: safeAreaLayoutGuide.topAnchor,
                     left: profileImage.safeAreaLayoutGuide.rightAnchor,
                     right: safeAreaLayoutGuide.rightAnchor,
                     paddingTop: 8,
                     paddingLeft: 8,
                     paddingRight: 8)
        
        let stackButtons = UIStackView(arrangedSubviews: [commentButton, retweetButton, likeButton, shareButton])
        stackButtons.axis = .horizontal
        stackButtons.spacing = 72
        
        addSubview(stackButtons)
        stackButtons.centerX(inView: self)
        stackButtons.anchor(bottom: bottomAnchor, paddingBottom: 8)
        
        addSubview(underlineView)
        underlineView.anchor(left: safeAreaLayoutGuide.leftAnchor,
                             bottom: safeAreaLayoutGuide.bottomAnchor,
                             right: safeAreaLayoutGuide.rightAnchor, paddingBottom: 0, height: 1)
        
        
    }
    
    private func configure() {
        guard let tweet = tweet else { return }
        let viewModel = TweetViewModel(tweet: tweet)
        
        profileImage.sd_setImage(with: viewModel.profileImageUrl, completed: nil)
        infoLabel.attributedText = viewModel.userInfoText
        captionLabel.text = tweet.caption
        likeButton.tintColor = viewModel.likeButtonTintColor
        likeButton.setImage(viewModel.likeButtonImage, for: .normal)
    }
    
    private func configureMention() {
        captionLabel.handleMentionTap { mention in
            self.delegate?.didFetchUser(withUsername: mention)
        }
    }
}
