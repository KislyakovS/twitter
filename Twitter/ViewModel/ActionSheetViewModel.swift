//
//  ActionSheetViewModel.swift
//  Twitter
//
//  Created by Александр Кисляков on 22.03.2021.
//

import Foundation

enum ActionSheetOptions {
    case follow(User)
    case unfollow(User)
    case report
    case delete
    case blockUser
    
    var description: String {
        switch self {
        case .follow(let user):
            return "Follow @\(user.username)"
        case .unfollow(let user):
            return "Unfollow @\(user.username)"
        case .report:
            return "Report Tweet"
        case .delete:
            return "Delete Tweet"
        case .blockUser:
            return "Block User"
        }
    }
}

struct ActionSheetViewModel {
    private let user: User
    
    var options: [ActionSheetOptions] {
        var result = [ActionSheetOptions]()
        
        if user.isCurrentUser {
            result.append(.delete)
        } else {
            let followOption: ActionSheetOptions = user.isFollowed ? .unfollow(user) : .follow(user)
            result.append(followOption)
            result.append(.blockUser)
        }
        
        result.append(.report)
        
        return result
    }
    
    init(user: User) {
        self.user = user
    }
}
