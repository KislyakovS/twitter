//
//  Tweer.swift
//  Twitter
//
//  Created by Александр Кисляков on 16.03.2021.
//

import Foundation

struct Tweet {
    let caption: String
    let tweetID: String
    let likes: Int
    var timestamp: Date!
    let retweetCount: Int
    var user: User
    
    init(user: User, tweetID: String, dictionary: [String: Any]) {
        self.tweetID = tweetID
        self.user = user
        
        self.caption = dictionary["caption"] as? String ?? ""
        self.likes = dictionary["likes"] as? Int ?? 0
        self.retweetCount = dictionary["retweets"] as? Int ?? 0
        
        if let user = dictionary["user"] as? User {
            self.user = user
        }
        
        if let timestamp = dictionary["timestamp"] as? Double {
            self.timestamp = Date(timeIntervalSince1970: timestamp)
        }
    }
}
