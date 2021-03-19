//
//  ProfileHeaderViewModel.swift
//  Twitter
//
//  Created by Александр Кисляков on 18.03.2021.
//

import UIKit
import Firebase

enum ProfileFilterOptions: Int, CaseIterable {
    case tweets
    case replice
    case likes
    
    var description: String {
        switch self {
            case .tweets: return "Tweets"
            case .replice: return "Tweets & Replies"
            case .likes: return "Likes"
        }
    }
}

struct ProfileHeaderViewModel {
    
    private let user: User
    
    var followersText: NSAttributedString? {
        return attributedString(withValue: 0, text: "followers")
    }
    
    var followingText: NSAttributedString? {
        return attributedString(withValue: 2, text: "following")
    }
    
    var username: String? {
        return "@\(user.username)"
    }
    
    var actionButtonTitle: String? {
        if user.isCurrentUser {
            return "Edit Profile"
        }
        
        return "Following"
    }
    
    init(user: User ) {
        self.user = user
    }
    
    private func attributedString(withValue value: Int, text: String ) -> NSAttributedString {
        let attributeTitle = NSMutableAttributedString(string: "\(value)",
                                             attributes: [.font: UIFont.systemFont(ofSize: 14),
                                                       .foregroundColor: UIColor.black])
        attributeTitle.append(NSAttributedString(string: " \(text)",
                                                 attributes: [.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.lightGray]))
        
        return attributeTitle
    }
}
