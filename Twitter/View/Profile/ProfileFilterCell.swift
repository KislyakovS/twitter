//
//  ProfileFilterCell.swift
//  Twitter
//
//  Created by Александр Кисляков on 17.03.2021.
//

import UIKit

class ProfileFilterCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    var option: ProfileFilterOptions! {
        didSet {
            titleLabel.text = option.description
        }
    }
    
    static let identifier = "ProfileFilterCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            titleLabel.font = isSelected
                ? UIFont.boldSystemFont(ofSize: 14)
                : UIFont.systemFont(ofSize: 14)
            titleLabel.textColor = isSelected
                ? .twitterBlue
                : .lightGray
        }
    }
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        addSubview(titleLabel)
        titleLabel.text = "Hello"
        titleLabel.center(inView: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
