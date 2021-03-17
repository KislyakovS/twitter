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
}
