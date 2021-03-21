//
//  UploadTweetController.swift
//  Twitter
//
//  Created by Александр Кисляков on 15.03.2021.
//

import UIKit
import SDWebImage

class UploadTweetController: UIViewController {
    
    // MARK: - Properties
    
    private let user: User
    private let config: UploadTweetConfiguration
    private lazy var viewModel = UploadTweetViewModel(config: config)
    
    private lazy var buttonTweet: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .twitterBlue
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Tweet", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        button.frame = CGRect(x: 0, y: 0, width: 70, height: 32)
        button.layer.cornerRadius = 32/2
        
        button.addTarget(self, action: #selector(didTapUploadTweet), for: .touchUpInside)
                
        return button
    }()
    
    private let profileImage: UIImageView = {
       let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.setDimensions(width: 48, height: 48)
        image.layer.cornerRadius = 48/2
        return image
    }()
    
    private lazy var replyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        label.text = "Replying to @spiderman"
        label.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        return label
    }()
    
    private let captionTextView = CaptionTextView()

    // MARK: - Lifecycle
    
    init(user: User, config: UploadTweetConfiguration) {
        self.user = user
        self.config = config
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configure()
    }
    
    // MARK: - API
    
    // MARK: - Did
    
    @objc private func didTapCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapUploadTweet() {
        guard let caption = captionTextView.text else { return }
        TweetService.shared.uploadTweet(caprion: caption, type: config) { (error, ref) in
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        view.backgroundColor = .white
        
        configureNavigationBar()
        
        let imageCaptionStack = UIStackView(arrangedSubviews: [profileImage, captionTextView])
        imageCaptionStack.axis = .horizontal
        imageCaptionStack.spacing = 12
        imageCaptionStack.alignment = .leading
        
        let stack = UIStackView(arrangedSubviews: [replyLabel, imageCaptionStack])
        stack.axis = .vertical
        stack.spacing = 12
        
        view.addSubview(stack)
        stack.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                     left: view.safeAreaLayoutGuide.leftAnchor,
                     right: view.safeAreaLayoutGuide.rightAnchor,
                     paddingTop: 16, paddingLeft: 16, paddingRight: 16)
        profileImage.sd_setImage(with: user.profileImageUrl, completed: nil)
    }
    
    private func configure() {
        buttonTweet.setTitle(viewModel.actionButtonTitle, for: .normal)
        captionTextView.placeholderLabel.text = viewModel.placeholderText
        
        replyLabel.isHidden = !viewModel.shouldShowReplyLabel
        guard let replyText = viewModel.replyText else { return }
        replyLabel.text = replyText
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.isTranslucent = false
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(didTapCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: buttonTweet)
    }

}
