//
//  JoinViewController.swift
//  TodoAPP_project
//
//  Created by Bowon Han on 12/1/23.
//

import UIKit
import SnapKit

final class JoinViewController : UIViewController {
    private let joinLabel : UILabel = {
        let label = UILabel()
        label.text = "Join"
        label.font = UIFont.systemFont(ofSize: 40, weight: .black)
        label.textColor = .darkGreen
        
        return label
    }()
    
    let joinEmail : InputView = {
        let inputView = InputView()
        inputView.inputLabel.text = "email"
        inputView.inputTextField.placeholder = "email을 입력해주세요."
        
        return inputView
    }()
    
    let joinNickname : InputView = {
        let inputView = InputView()
        inputView.inputLabel.text = "nickname"
        inputView.inputTextField.placeholder = "닉네임을 입력해주세요."
        
        return inputView
    }()
    
    let joinPassword : InputView = {
        let inputView = InputView()
        inputView.inputLabel.text = "password"
        inputView.inputTextField.placeholder = "비밀번호를 입력해주새요."
        
        return inputView
    }()
    
    private lazy var joinButton : UIButton = {
        let button = UIButton()
        button.setTitle("join", for: .normal)
        button.tintColor = .white
        button.layer.borderWidth = 10
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.darkYellow.cgColor
        button.layer.backgroundColor = UIColor.darkYellow.cgColor
        button.addTarget(self, action: #selector(tabJoinButton), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setLayout()
    }
    
    @objc private func tabJoinButton() {
        self.dismiss(animated: false)
    }
    
    private func setLayout() {
        [joinLabel,
         joinNickname,
         joinPassword,
         joinEmail,
         joinButton].forEach {
            view.addSubview($0)
        }
                
        joinLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(60)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(40)
        }
        
        joinEmail.snp.makeConstraints {
            $0.top.equalTo(joinLabel.snp.bottom).offset(50)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(40)
        }
        
        joinNickname.snp.makeConstraints {
            $0.top.equalTo(joinEmail.snp.bottom).offset(30)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(40)
        }
        
        joinPassword.snp.makeConstraints {
            $0.top.equalTo(joinNickname.snp.bottom).offset(30)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(40)
        }
        
        joinButton.snp.makeConstraints {
            $0.top.equalTo(joinPassword.snp.bottom).offset(50)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-40)
            $0.width.equalTo(100)
            $0.height.equalTo(40)
        }
    }
}
