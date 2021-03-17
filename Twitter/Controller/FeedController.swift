//
//  FeedController.swift
//  Twitter
//
//  Created by Александр Кисляков on 10.03.2021.
//

import UIKit
import SDWebImage

class FeedController: UICollectionViewController {

    // MARK: - Properties
    
    var user: User? {
        didSet {
            configureLeftBarButton()
        }
    }
    
    private var tweets = [Tweet]() {
        didSet {
            collectionView.reloadData()
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
        fetchTweets()
    }
    
    // MARK: - API
    
    private func fetchTweets() {
        TweetService.shared.fetchTweets { tweets in
            self.tweets = tweets
        }
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        view.backgroundColor = .white
        
        collectionView.register(TweetCollectionViewCell.self, forCellWithReuseIdentifier: TweetCollectionViewCell.identifier)
        collectionView.backgroundColor = .white
        navigationItem.titleView = logoImage
    }
    
    private func configureLeftBarButton() {
        guard let user = user else { return }
        profileImage.sd_setImage(with: user.profileImageUrl, completed: nil)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileImage)
    }
}

// MARK - UICollectionViewDelegate

extension FeedController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tweets.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TweetCollectionViewCell.identifier, for: indexPath) as! TweetCollectionViewCell
        cell.tweet = tweets[indexPath.row]
        return cell
    }
}

// MARK - UICollectionViewDelegateFlowLayout

extension FeedController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
