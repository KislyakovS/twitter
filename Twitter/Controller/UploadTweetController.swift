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
    
    private let user: User?
    
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
    
    private let captionTextView = CaptionTextView()

    // MARK: - Lifecycle
    
    init(user: User?) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - API
    
    // MARK: - Did
    
    @objc private func didTapCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapUploadTweet() {
        guard let caption = captionTextView.text else { return }
        TweetService.shared.uploadTweet(caprion: caption) { (error, ref) in
            print("DEBUG: Upload new tweet")
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        view.backgroundColor = .white
        
        configureNavigationBar()
        
        let stack = UIStackView(arrangedSubviews: [profileImage, captionTextView])
        stack.axis = .horizontal
        stack.spacing = 12
        
        view.addSubview(stack)
        stack.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                     left: view.safeAreaLayoutGuide.leftAnchor,
                     right: view.safeAreaLayoutGuide.rightAnchor,
                     paddingTop: 16, paddingLeft: 16, paddingRight: 16)
        profileImage.sd_setImage(with: user?.profileImageUrl, completed: nil)
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.isTranslucent = false
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(didTapCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: buttonTweet)
    }

}
