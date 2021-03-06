//
//  ReplyController.swift
//  Twitter
//
//  Created by Александр Кисляков on 21.03.2021.
//

import UIKit

class ReplyController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var buttonTweet: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .twitterBlue
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Reply", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        button.frame = CGRect(x: 0, y: 0, width: 70, height: 32)
        button.layer.cornerRadius = 32/2
        
        button.addTarget(self, action: #selector(didTapUploadTweet), for: .touchUpInside)
                
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - Did
    
    @objc private func didTapCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapUploadTweet() {
//        guard let caption = captionTextView.text else { return }
//        TweetService.shared.uploadTweet(caprion: caption) { (error, ref) in
//            self.dismiss(animated: true, completion: nil)
//        }
    }
    
    // MARK: - Helpers

    private func configureUI() {
        view.backgroundColor = .white
        
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.isTranslucent = false
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(didTapCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: buttonTweet)
    }
}
