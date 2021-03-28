//
//  UserService.swift
//  Twitter
//
//  Created by Александр Кисляков on 15.03.2021.
//

import Firebase

struct UserService {
    static let shared = UserService()
    
    func fetchUser(uid: String, completion: @escaping (User) -> Void) {
        REF_USERS.child(uid).observeSingleEvent(of: .value) { snapshot in
            guard let dictinary = snapshot.value as? [String: Any] else { return }
                
            let user = User(uid: uid, dictinary: dictinary)
                
            completion(user)
        }
    }
    
    func fetchUser(withUsername username: String, completion: @escaping (User) -> Void) {
        REF_USER_USERNAME.child(username).observeSingleEvent(of: .value) { snapshot in
            guard let uid = snapshot.value as? String else { return }
            self.fetchUser(uid: uid, completion: completion)
        }
    }
    
    func fetchUsers(completion: @escaping ([User]) -> Void) {
        var users = [User]()
        
        REF_USERS.observe(.childAdded) { snapshot in
            let uid = snapshot.key
            guard let dictinory = snapshot.value as? [String: Any] else { return }
                
            let user = User(uid: uid, dictinary: dictinory)
            users.append(user)
                
            completion(users)
        }
    }
    
    func followUser(uid: String, completion: @escaping (Error?, DatabaseReference) -> Void) {
        guard let currenUid = Auth.auth().currentUser?.uid else { return }
        
        REF_USER_FOLLOWING.child(currenUid).updateChildValues([uid: 1]) { (error, ref) in
            REF_USER_FOLLOWERS.child(uid).updateChildValues([currenUid: 1], withCompletionBlock: completion)
        }
    }
    
    func unfollowUser(uid: String, completion: @escaping (Error?, DatabaseReference) -> Void) {
        guard let currenUid = Auth.auth().currentUser?.uid else { return }
        
        REF_USER_FOLLOWING.child(currenUid).child(uid).removeValue() { (error, ref) in
            REF_USER_FOLLOWERS.child(uid).child(currenUid).removeValue(completionBlock: completion )
        }
    }
    
    func checkIfUserIsFollowed(uid: String, completion: @escaping (Bool) -> Void) {
        guard let currenUid = Auth.auth().currentUser?.uid else { return }
        
        REF_USER_FOLLOWING.child(currenUid).child(uid).observeSingleEvent(of: .value) { snapshot in
            completion(snapshot.exists())
        }
    }
    
    func fetchUserStats(uid: String, completion: @escaping (UserRelationStats) -> Void) {
        REF_USER_FOLLOWERS.child(uid).observeSingleEvent(of: .value) { snapshot in
            let followers = snapshot.children.allObjects.count
                        
            REF_USER_FOLLOWING.child(uid).observeSingleEvent(of: .value) { snapshot in
                let following = snapshot.children.allObjects.count
                
                let stats = UserRelationStats(followers: followers, following: following)
                
                completion(stats)
            }
        }
    }
    
    func updateProfileImage(image: UIImage, completion: @escaping (URL) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.3) else { return }
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let filename = NSUUID().uuidString
        let ref = STORAGE_PROFILE_IMAGES.child(filename)
        
        ref.putData(imageData, metadata: nil) { (meta, error) in
            ref.downloadURL { (url, error) in
                guard let profileImageUrl = url?.absoluteString else { return }
                let values = ["profileImageUrl": profileImageUrl]
                
                REF_USERS.child(uid).updateChildValues(values) { (error, ref) in
                    completion(URL(string: profileImageUrl)!)
                }
            }
        }
    }
    
    func saveUserData(user: User, completion: @escaping (Error?, DatabaseReference) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let values = ["fullname": user.fullname, "username": user.username, "bio": user.bio]
        
        REF_USERS.child(uid).updateChildValues(values, withCompletionBlock: completion)
    }
}
