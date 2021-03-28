//
//  EditProfileHeader.swift
//  Twitter
//
//  Created by Александр Кисляков on 25.03.2021.
//

import UIKit

protocol EditProfileHeaderDelegate: class {
    func didTapChengePhoto()
}

class EditProfileHeader: UIView {
    
    // MARK:  - Properties
    
    private let user: User
    weak var delegate: EditProfileHeaderDelegate?
    
    let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        iv.layer.borderColor = UIColor.white.cgColor
        iv.layer.borderWidth = 3
        return iv
    }()
    
    private lazy var changePhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitle("Change Profile Photo", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(didTapChangePhoto), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    init(user: User) {
        self.user = user
        
        super.init(frame: .zero)
    
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Did
    
    @objc private func didTapChangePhoto() {
        delegate?.didTapChengePhoto()
    }

    // MARK: - API

    // MARK: - Helpers

    private func configureView() {
        backgroundColor = .twitterBlue
        
        addSubview(profileImageView)
        profileImageView.setDimensions(width: 120, height: 120)
        profileImageView.layer.cornerRadius = 120 / 2
        profileImageView.center(inView: self, yConstant: -16)
        profileImageView.sd_setImage(with: user.profileImageUrl)
        
        addSubview(changePhotoButton)
        changePhotoButton.centerX(inView: self)
        changePhotoButton.anchor(top: profileImageView.bottomAnchor, paddingTop: 5)
    }
}
