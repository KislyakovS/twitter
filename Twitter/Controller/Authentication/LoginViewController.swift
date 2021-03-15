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

        return Utilites().inputContainerView(image: image, textField: emailTextField)
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        let placeholder = NSAttributedString(string: "Email",
                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        textField.attributedPlaceholder = placeholder
        textField.textColor = .white
        return textField
    }()
    
    private lazy var passwordContainerView: UIView = {
        let image = UIImage(named: "ic_lock_outline_white_2x")
        
        return Utilites().inputContainerView(image: image, textField: passwordTextField)
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        let placeholder = NSAttributedString(string: "Password",
                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        textField.attributedPlaceholder = placeholder
        textField.isSecureTextEntry = true
        textField.textColor = .white
        return textField
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
        let button = Utilites().attributedButton("Don't have an account?", "Sign Up")
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
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        AuthService.shared.logUserIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("DEBUG: Error in \(error.localizedDescription)")
                return
            }
            
            guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
            guard let tab = window.rootViewController as? MainTabController else { return }
            
            tab.authenticateUserAndConfigureUI()
            
            self.dismiss(animated: true, completion: nil)
        }
    } 
    
    @objc private func didTapRegisterButton() {
        let vc = RegistrationViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        view.backgroundColor = .twitterBlue
        
        view.addSubview(logoImage)
        logoImage.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor)
        logoImage.setDimensions(width: 170, height: 170)
        
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

}
