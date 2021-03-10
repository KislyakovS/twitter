//
//  ExploreController.swift
//  Twitter
//
//  Created by Александр Кисляков on 10.03.2021.
//

import UIKit

class ExploreController: UIViewController {

    // MARK: - Properties
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewController()
    }
    
    // MARK: - Helpers
    
    private func configureViewController() {
        view.backgroundColor = .white
        
        navigationItem.title = "Explore"
    }
}

