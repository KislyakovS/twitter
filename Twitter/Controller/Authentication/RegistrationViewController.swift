//
//  RegistrationViewController.swift
//  Twitter
//
//  Created by Александр Кисляков on 10.03.2021.
//

import UIKit

class RegistrationViewController: UIViewController {

    // MARK: - Properties
    
    private let imagePicker = UIImagePickerController()
    
    private let photoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "plus_photo"), for: .normal)
        button.tintColor = .white
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(didTapPhotoButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var emailContainerView: UIView = {
        let image = UIImage(named: "ic_mail_outline_white_2x-1")
        
        let textField = UITextField()
        let placeholder = NSAttributedString(string: "Email",
                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        textField.attributedPlaceholder = placeholder
        textField.textColor = .white
        return Utilites().inputContainerView(image: image, textField: textField)
    }()
    
    private lazy var passwordContainerView: UIView = {
        let image = UIImage(named: "ic_lock_outline_white_2x")
        
        let textField = UITextField()
        let placeholder = NSAttributedString(string: "Password",
                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        textField.attributedPlaceholder = placeholder
        textField.isSecureTextEntry = true
        textField.textColor = .white
        return Utilites().inputContainerView(image: image, textField: textField)
    }()
    
    private lazy var fullNameContainerView: UIView = {
        let image = UIImage(named: "ic_person_outline_white_2x")
        
        let textField = UITextField()
        let placeholder = NSAttributedString(string: "Full Name",
                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        textField.attributedPlaceholder = placeholder
        textField.textColor = .white
        return Utilites().inputContainerView(image: image, textField: textField)
    }()
    
    private lazy var userNameContainerView: UIView = {
        let image = UIImage(named: "ic_person_outline_white_2x")
        
        let textField = UITextField()
        let placeholder = NSAttributedString(string: "Username",
                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        textField.attributedPlaceholder = placeholder
        textField.textColor = .white
        return Utilites().inputContainerView(image: image, textField: textField)
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.setTitleColor(.twitterBlue, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
        return button
    }()
    
    private let stubView: UIView = {
        let view = UIView()
        view.setDimensions(width: 0, height: 10)
        return view
    }()
    
    private let haveAccountButton: UIButton = {
        let button = Utilites().attributedButton("Already have an account?", "Log In")
        button.addTarget(self, action: #selector(didTapHaveAccountButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        configureUI()
    }
    
    // MARK: - Did
    
    @objc private func didTapSignUp() {
        
    }
    
    @objc private func didTapHaveAccountButton() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapPhotoButton() {
        present(imagePicker, animated: true, completion: nil)
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        view.backgroundColor = .twitterBlue
        
        view.addSubview(photoButton)
        photoButton.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor)
        photoButton.setDimensions(width: 120, height: 120)
        photoButton.layer.cornerRadius = 120/2
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, fullNameContainerView, userNameContainerView, stubView, signUpButton])
        stack.axis = .vertical
        stack.spacing = 8
        
        view.addSubview(stack)
        stack.anchor(top: photoButton.safeAreaLayoutGuide.bottomAnchor,
                     left: view.safeAreaLayoutGuide.leftAnchor,
                     right: view.safeAreaLayoutGuide.rightAnchor,
                     paddingTop: 20,
                     paddingLeft: 20,
                     paddingRight: 20)
        
        view.addSubview(haveAccountButton)
        haveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor,
                              paddingBottom: 10,
                              height: 10)
        haveAccountButton.centerX(inView: view)

    }

}

extension RegistrationViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let photo = info[.editedImage] as? UIImage else { return }
        
        photoButton.imageView?.contentMode = .scaleAspectFill
        photoButton.layer.borderWidth = 2
        photoButton.layer.borderColor = UIColor.white.cgColor
        photoButton.setImage(photo.withRenderingMode(.alwaysOriginal), for: .normal)
            
        picker.dismiss(animated: true, completion: nil)
    }
        
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
