//
//  Utilites.swift
//  Twitter
//
//  Created by Александр Кисляков on 10.03.2021.
//

import UIKit

struct Utilites {
    func inputContainerView(image: UIImage?, textField: UITextField) -> UIView {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let imageView = UIImageView(image: image)
        view.addSubview(imageView)
        imageView.anchor(left: view.safeAreaLayoutGuide.leftAnchor,
                     bottom: view.safeAreaLayoutGuide.bottomAnchor,
                     paddingBottom: 8)
        imageView.setDimensions(width: 24, height: 24)
        
        view.addSubview(textField)
        textField.anchor(left: imageView.safeAreaLayoutGuide.rightAnchor,
                     bottom: view.safeAreaLayoutGuide.bottomAnchor,
                     right: view.safeAreaLayoutGuide.rightAnchor,
                     paddingLeft: 5,
                     paddingBottom: 8,
                     paddingRight: 0)
        
        let dividerView = UIView()
        dividerView.backgroundColor = .white
        view.addSubview(dividerView)
        dividerView.anchor(left: view.safeAreaLayoutGuide.leftAnchor,
                           bottom: view.safeAreaLayoutGuide.bottomAnchor,
                           right: view.safeAreaLayoutGuide.rightAnchor,
                           height: 0.5)
        
        return view
    }
    
    func attributedButton(_ first: String, _ second: String) -> UIButton {
        let button = UIButton()
        
        let title = NSMutableAttributedString(string: "\(first) ",
                                              attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.white])
        title.append(NSAttributedString(string: second,
                                        attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.white]))

        button.setAttributedTitle(title, for: .normal)
        return button
    }
}
