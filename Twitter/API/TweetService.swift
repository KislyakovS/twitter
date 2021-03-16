//
//  TweetService.swift
//  Twitter
//
//  Created by Александр Кисляков on 15.03.2021.
//

import Firebase

struct TweetService {
    static let shared = TweetService()
    
    func uploadTweet(caprion: String, completion: @escaping (Error?, DatabaseReference) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let values = ["uid": uid,
                      "timestamp": Int(NSDate().timeIntervalSince1970),
                      "likes": 0,
                      "retweets": 0,
                      "caption": caprion] as [String : Any]
        
        REF_TWEETS.childByAutoId().updateChildValues(values, withCompletionBlock: completion)
    }
    
    func fetchTweets(completion: @escaping ([Tweet]) -> Void) {
        var tweets = [Tweet]()
        
        REF_TWEETS.observe(.childAdded) { snapshot in
            let tweet = Tweet(tweetID: snapshot.key, dictionary: snapshot.value as! [String: Any])
            tweets.append(tweet)
            completion(tweets)
        }
    }
}
