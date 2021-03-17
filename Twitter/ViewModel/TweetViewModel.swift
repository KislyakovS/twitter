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
    
    var userInfoText: NSAttributedString {
        let userInfo = NSMutableAttributedString(string: tweet.user.fullname,
                                          attributes: [.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.black])
        userInfo.append(NSAttributedString(string: " @\(tweet.user.username)",
                                           attributes: [.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.lightGray]))
        userInfo.append(NSAttributedString(string: " • \(timestamp)",
                                           attributes: [.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.lightGray]))
        
        return userInfo
    }
    
    init(tweet: Tweet) {
        self.tweet = tweet
    }
}
