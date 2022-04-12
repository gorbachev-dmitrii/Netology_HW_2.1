//
//  LoginViewController.swift
//  Netology_HW_2.1
//
//  Created by Dima Gorbachev on 27.03.2022.
//

import UIKit
import KeychainAccess

class LoginViewController: UIViewController {
    
    private let keychain = Keychain(service: "NetologyHW")
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
        textField.placeholder = "Type in your password"
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
            if input.count > 4 {
                if tempPass == input {
                    print("povtornii vvod")
                    keychain["user"] = tempPass
                } else {
                    loginButton.setTitle("Повторите пароль", for: .normal)
                    tempPass = input
                    print(tempPass)
                }
            } else {
                print("пароль менее 4 символов")
            }
        } else {
            print("password is nil")
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
    
    func checkState() {
        if keychain["user"] != nil {
            loginButton.setTitle("Введите пароль", for: .normal)
            print("Пароль был сохранен")
        } else {
            loginButton.setTitle("Создать пароль", for: .normal)
            print("Нет сохраненного пароля")
        }
    }
    
}

