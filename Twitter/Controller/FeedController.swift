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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - Did
    
    @objc private func didRefresh() {
        fetchTweets()
    }
    
    // MARK: - API
    
    private func fetchTweets() {
        collectionView.refreshControl?.beginRefreshing()
        TweetService.shared.fetchTweets { tweets in
            self.tweets = tweets
            
            for (index, tweet) in tweets.enumerated() {
                TweetService.shared.checkIfUserLikedTweet(tweet) { didLike in
                    guard didLike == true else { return }
                    
                    self.tweets[index].didLike = true
                }
            }
            
            self.tweets = tweets.sorted(by: { $0.timestamp > $1.timestamp })
            
            self.collectionView.refreshControl?.endRefreshing()
        }
    }
    
    private func fetchUser(withUsername username: String) {
        UserService.shared.fetchUser(withUsername: username) { user in
            let controller = ProfileController(user: user)
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        collectionView.register(TweetCell.self, forCellWithReuseIdentifier: TweetCell.identifier)
        collectionView.backgroundColor = .white
        navigationItem.titleView = logoImage
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(didRefresh), for: .valueChanged)
        collectionView.refreshControl = refreshControl
    }
    
    private func configureLeftBarButton() {
        guard let user = user else { return }
        profileImage.sd_setImage(with: user.profileImageUrl, completed: nil)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileImage)
    }
}

// MARK: - UICollectionViewDelegate

extension FeedController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tweets.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TweetCell.identifier, for: indexPath) as! TweetCell
        cell.delegate = self
        cell.tweet = tweets[indexPath.row]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = TweetController(tweet: tweets[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK - UICollectionViewDelegateFlowLayout

extension FeedController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewModel = TweetViewModel(tweet: tweets[indexPath.row])
        let height = viewModel.size(forWidth: view.frame.width, fontSize: 16).height
        
        return CGSize(width: view.frame.width, height: height + 75)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

// MARK: - TweetCollectionViewCellDelegate

extension FeedController: TweetCollectionViewCellDelegate {
    func didTapLike(_ cell: TweetCell) {
        guard let tweet = cell.tweet else { return }
        
        TweetService.shared.likeTweet(tweet: tweet) { error, ref in
            cell.tweet?.didLike.toggle()
            let likes = tweet.didLike ? tweet.likes - 1 : tweet.likes + 1
            cell.tweet?.likes = likes
        }
    }
    
    func didTapProfile(_ user: User) {
        let vc = ProfileController(user: user)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func didTapComment(_ tweet: Tweet) {
        guard let user = user else { return }
        
        let vc = UINavigationController(rootViewController: UploadTweetController(user: user, config: .reply(tweet)))
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    func didFetchUser(withUsername username: String) {
        fetchUser(withUsername: username)
    }
}
