//
//  MainTabController.swift
//  Twitter
//
//  Created by Александр Кисляков on 10.03.2021.
//

import UIKit

class MainTabController: UITabBarController {

    // MARK: - Properties
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
    }
    
    // MARK: - Helpers
    private func configureViewController() {
        let feed = templateNavigationViewController(image: UIImage(named: "home_unselected"),
                                                    rootViewController: FeedController())
        
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
}
