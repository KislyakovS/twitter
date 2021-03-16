//
//  MainTabController.swift
//  Twitter
//
//  Created by Александр Кисляков on 10.03.2021.
//

import UIKit
import Firebase

class MainTabController: UITabBarController {

    // MARK: - Properties
    
    var user: User? {
        didSet {
            guard let nav = viewControllers?[0] as? UINavigationController else { return }
            guard let feed = nav.viewControllers.first as? FeedController else { return }
            
            feed.user = user
        }
    }
    
    private let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.backgroundColor = .twitterBlue
        button.setImage(UIImage(named: "new_tweet"), for: .normal)
        button.addTarget(self, action: #selector(didTapActionButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .twitterBlue
        authenticateUserAndConfigureUI()
    }
    
    // MARK: - API
    
    func fetchUser() {
        UserService.shared.fetchUser { user in
            self.user = user
        }
    }
    
    func authenticateUserAndConfigureUI() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let vc = LoginViewController()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            }
        } else {
            configureViewController()
            configureUI()
            fetchUser()
        }
    }
    
    // MARK: - Did
    
    @objc private func didTapActionButton() {
        //print("Tap action button")
        let uploadTweet = UINavigationController(rootViewController: UploadTweetController(user: user))
        uploadTweet.modalPresentationStyle = .fullScreen
        present(uploadTweet, animated: true, completion: nil)
    }
    
    // MARK: - Helpers
    
    private func configureViewController() {
        let feed = templateNavigationViewController(image: UIImage(named: "home_unselected"),
                                                    rootViewController: FeedController(collectionViewLayout: UICollectionViewFlowLayout()))
        
        let explore = templateNavigationViewController(image: UIImage(named: "search_unselected"),
                                                       rootViewController: ExploreController())
        
        let notifications = templateNavigationViewController(image: UIImage(named: "like_unselected"),
                                                             rootViewController: NotificationsController())
        
        let conversations = templateNavigationViewController(image: UIImage(named: "ic_mail_outline_white_2x-1"),
                                                             rootViewController: ConversationsController())
    
        viewControllers = [feed, explore, notifications, conversations]
    }
    
    private func templateNavigationViewController(image: UIImage?, rootViewController: UIViewController) -> UINavigationController {
        let viewController = UINavigationController(rootViewController: rootViewController)
        viewController.tabBarItem.image = image
        viewController.navigationBar.barTintColor = .white
        
        return viewController
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(actionButton)
        actionButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor,
                            right: view.safeAreaLayoutGuide.rightAnchor,
                            paddingBottom: 64,
                            paddingRight: 14,
                            width: 56,
                            height: 56)
        actionButton.layer.cornerRadius = 56/2
    }
}
