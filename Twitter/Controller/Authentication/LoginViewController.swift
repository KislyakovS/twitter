//
//  LoginViewController.swift
//  Twitter
//
//  Created by Александр Кисляков on 10.03.2021.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: - Properties
    
    private let logoImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "TwitterLogo"))
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var emailContainerView: UIView = {
        let image = UIImage(named: "ic_mail_outline_white_2x-1")
        
        let textField = UITextField()
        let placeholder = NSAttributedString(string: "Email",
                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        textField.attributedPlaceholder = placeholder
        textField.textColor = .white
        return templateInputContainer(image: image, textField: textField)
    }()
    
    private lazy var passwordContainerView: UIView = {
        let image = UIImage(named: "ic_lock_outline_white_2x")
        
        let textField = UITextField()
        let placeholder = NSAttributedString(string: "Password",
                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        textField.attributedPlaceholder = placeholder
        textField.isSecureTextEntry = true
        textField.textColor = .white
        return templateInputContainer(image: image, textField: textField)
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.setTitleColor(.twitterBlue, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.addTarget(self, action: #selector(didTapLogIn), for: .touchUpInside)
        return button
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton()
        
        let title = NSMutableAttributedString(string: "Don't have an account? ",
                                              attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.white])
        title.append(NSAttributedString(string: "Sign Up",
                                        attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.white]))

        button.setAttributedTitle(title, for: .normal)
        button.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
        return button
    }()
    
    private let stubView: UIView = {
        let view = UIView()
        view.setDimensions(width: 0, height: 10)
        return view
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - Did
    
    @objc private func didTapLogIn() {
        print("Log in")
    }
    
    @objc private func didTapRegisterButton() {
        print("Register")
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        view.backgroundColor = .twitterBlue
        
        view.addSubview(logoImage)
        logoImage.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                         width: 170,
                         height: 170)
        logoImage.centerX(inView: view)
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, stubView, loginButton])
        stack.axis = .vertical
        stack.spacing = 8
        
        view.addSubview(stack)
        stack.anchor(top: logoImage.safeAreaLayoutGuide.bottomAnchor,
                     left: view.safeAreaLayoutGuide.leftAnchor,
                     right: view.safeAreaLayoutGuide.rightAnchor,
                     paddingTop: 20,
                     paddingLeft: 20,
                     paddingRight: 20)
        
        view.addSubview(registerButton)
        registerButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor,
                              paddingBottom: 10,
                              height: 10)
        registerButton.centerX(inView: view)
    }
    
    private func templateInputContainer(image: UIImage?, textField: UITextField) -> UIView {
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
    
}
