//
//  UserService.swift
//  Twitter
//
//  Created by Александр Кисляков on 15.03.2021.
//

import Firebase

struct UserService {
    static let shared = UserService()
    
    func fetchUser(completion: @escaping (User) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        print("DEBUG: Uid user: \(uid)")
        REF_USERS.child(uid).observeSingleEvent(of: .value) { snaphot in
            guard let dictinary = snaphot.value as? [String: AnyObject] else { return }
            
            let user = User(uid: uid, dictinary: dictinary)
            
            completion(user)
        }
    }
}
