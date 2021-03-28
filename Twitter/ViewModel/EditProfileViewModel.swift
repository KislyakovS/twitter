//
//  EditProfileViewModel.swift
//  Twitter
//
//  Created by Александр Кисляков on 25.03.2021.
//

import Foundation

enum EditProfileOptions: Int, CaseIterable {
    case fullname
    case username
    case bio
    
    var description: String {
        switch self {
        case .fullname: return "Name"
        case .username: return "Username"
        case .bio: return "Bio"
        }
    }
}

struct EditProfileViewModel {
    
    private let user: User
    let option: EditProfileOptions
    
    var titleText: String {
        return option.description
    }
    
    var optionValue: String? {
        switch option {
        case .fullname: return user.fullname
        case .username: return user.username
        case .bio: return ""
        }
    }
    
    var placeholder: String? {
        switch option {
        case .fullname: return "Full Name"
        case .username: return "User Name"
        case .bio: return "Bio"
        }
    }
    
    init(user: User, option: EditProfileOptions) {
        self.user = user
        self.option = option
    }
}
