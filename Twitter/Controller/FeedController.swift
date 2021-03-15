//
//  FeedController.swift
//  Twitter
//
//  Created by Александр Кисляков on 10.03.2021.
//

import UIKit
import SDWebImage

class FeedController: UIViewController {

    // MARK: - Properties
    
    var user: User? {
        didSet {
            configureLeftBarButton()
        }
    }
    
    private let logoImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "twitter_logo_blue"))
        image.setDimensions(width: 44, height: 44)
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let profileImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .twitterBlue
        image.setDimensions(width: 32, height: 32)
        image.layer.cornerRadius = 32/2
        image.clipsToBounds = true
        return image
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        view.backgroundColor = .white
        
        navigationItem.titleView = logoImage
    }
    
    private func configureLeftBarButton() {
        guard let user = user else { return }
        profileImage.sd_setImage(with: user.profileImageUrl, completed: nil)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileImage)
    }
}

