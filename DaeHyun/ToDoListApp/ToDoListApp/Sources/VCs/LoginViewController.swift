//
//  LoginViewController.swift
//  ToDoListApp
//
//  Created by 이대현 on 12/20/23.
//

import Moya
import SnapKit
import UIKit

class LoginViewController: UIViewController {
    private lazy var titleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "list.clipboard")
        imageView.tintColor = .red
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(50)
        }
        return imageView
        
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "앱센터 To-Do 리스트"
        label.font = .systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    
    private lazy var titleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleImageView, titleLabel])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
        return stackView
    }()
    
    private lazy var idLabel: UILabel = {
        let label = UILabel()
        label.text = "아이디"
        return label
    }()
    
    private lazy var idTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호"
        return label
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.text = "status"
        return label
    }()
    
    private lazy var loginButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .red
        config.baseForegroundColor = .black
        config.title = "로그인"
        
        let button = UIButton(configuration: config)
        button.addAction(UIAction { [weak self] _ in
            self?.moveToMain()
            
            
        }, for: .touchUpInside)
        return button
    }()
    
    private func checkLogin() {
        
    }
    
    private func moveToMain() {
        let tabBarVC = MainTabBarController()
        tabBarVC.view.backgroundColor = .systemBackground
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootVC(tabBarVC, animated: true)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        layout()
    }
    
    private func layout() {
        self.view.addSubview(titleStackView)
        titleStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(150)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        
        self.view.addSubview(idLabel)
        idLabel.snp.makeConstraints { make in
            make.top.equalTo(titleStackView.snp.bottom).offset(50)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-30)
        }
        
        self.view.addSubview(idTextField)
        idTextField.snp.makeConstraints { make in
            make.top.equalTo(idLabel.snp.bottom).offset(30)
            make.left.right.equalTo(idLabel)
        }
        
        self.view.addSubview(passwordLabel)
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(idTextField.snp.bottom).offset(30)
            make.left.right.equalTo(idTextField)
        }
        
        self.view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(30)
            make.left.right.equalTo(passwordLabel)
        }
        
        self.view.addSubview(statusLabel)
        statusLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(30)
            make.left.right.equalTo(passwordTextField)
        }
        
        self.view.addSubview(loginButton)
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(statusLabel.snp.bottom).offset(30)
            make.left.right.equalTo(statusLabel)
            make.height.equalTo(50)
        }
    }
}
