//
//  TweetCollectionViewCell.swift
//  Twitter
//
//  Created by Александр Кисляков on 16.03.2021.
//

import UIKit
import SDWebImage

class TweetCollectionViewCell: UICollectionViewCell {
        
    // MARK: - Properties
    
    static let identifier = "tweetCell"
    
    private let profileImage: UIImageView = {
       let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.setDimensions(width: 48, height: 48)
        image.layer.cornerRadius = 48/2
        image.backgroundColor = .twitterBlue
        return image
    }()
    
    private let captionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
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
        
        backgroundColor = .white
        
        configureUI()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        addSubview(profileImage)
        profileImage.anchor(top: safeAreaLayoutGuide.topAnchor,
                            left: safeAreaLayoutGuide.leftAnchor,
                            paddingTop: 16,
                            paddingLeft: 16)
        
        let stack = UIStackView(arrangedSubviews: [infoLabel, captionLabel])
        stack.axis = .vertical
        stack.spacing = 4
        
        infoLabel.text = "Eddie Brock @venom"
        captionLabel.text = "Hello my frends!"
        
        addSubview(stack)
        stack.anchor(top: safeAreaLayoutGuide.topAnchor,
                     left: profileImage.safeAreaLayoutGuide.rightAnchor,
                     right: safeAreaLayoutGuide.rightAnchor,
                     paddingTop: 16,
                     paddingLeft: 8,
                     paddingRight: 16)
        
        let stackButtons = UIStackView(arrangedSubviews: [commentButton, retweetButton, likeButton, shareButton])
        stackButtons.axis = .horizontal
        stackButtons.spacing = 72
        
        addSubview(stackButtons)
        stackButtons.centerX(inView: self)
        stackButtons.anchor(bottom: safeAreaLayoutGuide.bottomAnchor, paddingBottom: 8)
        
        addSubview(underlineView)
        underlineView.anchor(left: safeAreaLayoutGuide.leftAnchor,
                             bottom: safeAreaLayoutGuide.bottomAnchor,
                             right: safeAreaLayoutGuide.rightAnchor, paddingBottom: 0, height: 1)
    }
}
