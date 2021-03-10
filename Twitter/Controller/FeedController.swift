//
//  FeedController.swift
//  Twitter
//
//  Created by Александр Кисляков on 10.03.2021.
//

import UIKit

class FeedController: UIViewController {

    // MARK: - Properties
    
    private let logoImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "twitter_logo_blue"))
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
    }
    
    // MARK: - Helpers
    
    private func configureViewController() {
        view.backgroundColor = .white
        
        navigationItem.titleView = logoImage
    }
}

