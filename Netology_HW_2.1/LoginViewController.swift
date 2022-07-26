//
//  LoginViewController.swift
//  Netology_HW_2.1
//
//  Created by Dima Gorbachev on 27.03.2022.
//

import UIKit
import KeychainAccess

class LoginViewController: UIViewController {
    
    private let keychain = Keychain(service: Constants.keychainService)
    private var tempPass = ""
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
        return button
    }()
    
    private lazy var passwordInput: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Введите пароль"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(passwordInput)
        view.addSubview(loginButton)
        setupConstraints()
        checkState()
    }
    
    @objc func loginButtonClicked() {
        if let input = passwordInput.text {
            if checkState() == 0 {
                if input.count > Constants.passwordLength {
                    if tempPass == input {
                        keychain[Constants.userName] = tempPass
                    } else {
                        loginButton.setTitle("Повторите пароль", for: .normal)
                        tempPass = input
                    }
                } else {
                    passwordLengthAlert()
                }
            } else {
                if input == keychain[Constants.userName] {
                    let navigationController = UINavigationController.init(rootViewController: TabBarController())
                    view.window?.rootViewController = navigationController
                    view.window?.makeKeyAndVisible()
                } else {
                    incorrectPasswordAlert()
                }
            }
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            loginButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            loginButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            loginButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            
            passwordInput.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            passwordInput.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            passwordInput.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: -20)
        ])
    }
    
    private func checkState() -> Int {
        if keychain[Constants.userName] != nil {
            loginButton.setTitle("Введите пароль", for: .normal)
            return 1
        } else {
            loginButton.setTitle("Создать пароль", for: .normal)
            return 0
        }
    }
    
    private func incorrectPasswordAlert() {
        let alert = UIAlertController(title: "Неверный пароль", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    private func passwordLengthAlert() {
        let alert = UIAlertController(title: "Недопустимая длина пароля", message: "Создайте пароль длинной более 4-х символов", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
}

