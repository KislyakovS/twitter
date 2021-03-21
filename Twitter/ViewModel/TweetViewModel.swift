//
//  TweetViewModel.swift
//  Twitter
//
//  Created by Александр Кисляков on 17.03.2021.
//

import UIKit
import Foundation

struct TweetViewModel {
    let tweet: Tweet
    
    var profileImageUrl: URL? {
        return tweet.user.profileImageUrl
    }
    
    var timestamp: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        let now = Date()
        return formatter.string(from: tweet.timestamp, to: now) ?? "5m"
    }
    
    var headerTimestamp: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a • MM/dd/yyyy"
        return formatter.string(from: tweet.timestamp)
    }
    
    var username: String {
        return "@\(tweet.user.username)"
    }
    
    var userInfoText: NSAttributedString {
        let userInfo = NSMutableAttributedString(string: tweet.user.fullname,
                                          attributes: [.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.black])
        userInfo.append(NSAttributedString(string: " @\(tweet.user.username)",
                                           attributes: [.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.lightGray]))
        userInfo.append(NSAttributedString(string: " • \(timestamp)",
                                           attributes: [.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.lightGray]))
        
        return userInfo
    }
    
    var retweetsString: NSAttributedString {
        return attributedString(withValue: tweet.retweetCount, text: " Retweets")
    }
    
    var likesString: NSAttributedString {
        return attributedString(withValue: tweet.likes, text: " Likes")
    }
    
    init(tweet: Tweet) {
        self.tweet = tweet
    }
    
    private func attributedString(withValue value: Int, text: String ) -> NSAttributedString {
        let attributeTitle = NSMutableAttributedString(string: "\(value)",
                                             attributes: [.font: UIFont.systemFont(ofSize: 14),
                                                       .foregroundColor: UIColor.black])
        attributeTitle.append(NSAttributedString(string: " \(text)",
                                                 attributes: [.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.lightGray]))
        
        return attributeTitle
    }
    
    func size(forWidth width: CGFloat) -> CGSize {
        let label = UILabel()
        label.text = tweet.caption
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalToConstant: width).isActive = true
        return label.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    }
}
