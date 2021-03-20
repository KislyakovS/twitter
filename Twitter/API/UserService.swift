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
        REF_USERS.child(uid).observeSingleEvent(of: .value) { snaphot in
            guard let dictinary = snaphot.value as? [String: AnyObject] else { return }
            
            let user = User(uid: uid, dictinary: dictinary)
            
            completion(user)
        }
    }
    
    func fetchUsers(completion: @escaping ([User]) -> Void) {
        var users = [User]()
        
        REF_USERS.observe(.childAdded) { snapshot in
            let uid = snapshot.key
            guard let dictinory = snapshot.value as? [String: AnyObject] else { return }
            let user = User(uid: uid, dictinary: dictinory)
            
            users.append(user)
            
            completion(users)
        }
    }
}
