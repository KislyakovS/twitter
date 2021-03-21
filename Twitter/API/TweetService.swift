//
//  TweetService.swift
//  Twitter
//
//  Created by Александр Кисляков on 15.03.2021.
//

import Firebase

struct TweetService {
    static let shared = TweetService()
    
    func uploadTweet(caprion: String, type: UploadTweetConfiguration, completion: @escaping (Error?, DatabaseReference) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let values = ["uid": uid,
                      "timestamp": Int(NSDate().timeIntervalSince1970),
                      "likes": 0,
                      "retweets": 0,
                      "caption": caprion] as [String : Any]
        
        switch type {
        case .tweet:
            REF_TWEETS.childByAutoId().updateChildValues(values) { (error, ref) in
                guard let tweetID = ref.key else { return }
                REF_USER_TWEETS.child(uid).updateChildValues([tweetID: 1], withCompletionBlock: completion)
            }
        case .reply(let tweet):
            REF_TWEET_REPLY.child(tweet.tweetID).childByAutoId().updateChildValues(values, withCompletionBlock: completion)
        }
    }
    
    func fetchTweets(completion: @escaping ([Tweet]) -> Void) {
        var tweets = [Tweet]()
        
        REF_TWEETS.observe(.childAdded) { snapshot in
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            guard let uid = dictionary["uid"] as? String else { return }
            let key = snapshot.key
            
            UserService.shared.fetchUser(uid: uid) { user in
                let tweet = Tweet(user: user, tweetID: key, dictionary: dictionary)
                tweets.append(tweet)
                completion(tweets)
            }
        }
    }
    
    func fetchTweetsByUser(forUser user: User, completion: @escaping ([Tweet]) -> Void) {
        var tweets = [Tweet]()
        
        REF_USER_TWEETS.child(user.uid).observe(.childAdded) { snapshot in
            REF_TWEETS.child(snapshot.key).observeSingleEvent(of: .value) { snapshot in
                guard let dictionary = snapshot.value as? [String: Any] else { return }
                guard let uid = dictionary["uid"] as? String else { return }
                let key = snapshot.key
                
                UserService.shared.fetchUser(uid: uid) { user in
                    let tweet = Tweet(user: user, tweetID: key, dictionary: dictionary)
                    tweets.append(tweet)
                    completion(tweets)
                }
            }
        }
    }
    
    func fetchReply(forTweet tweet: Tweet, completion: @escaping ([Tweet]) -> Void) {
        var tweets = [Tweet]()
        
        REF_TWEET_REPLY.child(tweet.tweetID).observe(.childAdded) { snapshot in
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            guard let uid = dictionary["uid"] as? String else { return }
            let key = snapshot.key
            
            UserService.shared.fetchUser(uid: uid) { user in
                let tweet = Tweet(user: user, tweetID: key, dictionary: dictionary)
                tweets.append(tweet)
                completion(tweets)
            }
        }
    }
}
