//
//  User.swift
//  Twitter
//
//  Created by Александр Кисляков on 15.03.2021.
//

import Foundation
import Firebase

struct User {
    let fullname: String
    let username: String
    let email: String
    var profileImageUrl: URL?
    let uid: String
    var isFollowed = false
    var stats: UserRelationStats?
    
    var isCurrentUser: Bool { return uid == Auth.auth().currentUser?.uid }
    
    init(uid: String, dictinary: [String: Any]) {
        self.uid = uid
        
        self.fullname = dictinary["fullname"] as? String ?? ""
        self.username = dictinary["username"] as? String ?? ""
        self.email = dictinary["email"] as? String ?? ""
        if let profileImageUrlString = dictinary["profileImageUrl"] as? String {
            self.profileImageUrl = URL(string: profileImageUrlString)
        }
    }
}

struct UserRelationStats {
    var followers: Int
    var following: Int
}
