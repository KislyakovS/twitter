//
//  ActionSheetCell.swift
//  Twitter
//
//  Created by Александр Кисляков on 22.03.2021.
//

import UIKit

class ActionSheetCell: UITableViewCell {
    
    // MARK: - Properties
    
    var option: ActionSheetOptions? {
        didSet {
            configure()
        }
    }
    
    static let identifier = "ActionSheetCell"
    
    private let optionImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.image = UIImage(named: "twitter_logo_blue")
        return image
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = "Test Option"
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(optionImage)
        optionImage.centerY(inView: self)
        optionImage.anchor(left: leftAnchor, paddingTop: 8)
        optionImage.setDimensions(width: 36, height: 36)
        
        addSubview(titleLabel)
        titleLabel.centerY(inView: self)
        titleLabel.anchor(left: optionImage.rightAnchor, paddingLeft: 12)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configure() {
        guard let option = option else { return }

        titleLabel.text = option.description
    }
    
}
