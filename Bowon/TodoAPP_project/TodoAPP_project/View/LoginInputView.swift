//
//  LoginInputView.swift
//  TodoAPP_project
//
//  Created by Bowon Han on 11/30/23.
//

import UIKit
import SnapKit

final class LoginInputView : UIView {
    private lazy var loginInputStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.distribution = .fill
        stackView.alignment = .center
    
        return stackView
    }()
    
    let loginInputTextField : UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.setContentHuggingPriority(.defaultLow, for: .horizontal)
        textField.clearButtonMode = .always
        
        return textField
    }()
    
    let loginLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .thin)
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        return label
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setLayout() {
        [loginLabel,loginInputTextField].forEach {
            loginInputStackView.addArrangedSubview($0)
        }
        
        loginLabel.snp.makeConstraints {
            $0.width.equalTo(100)
        }
        
        loginInputTextField.snp.makeConstraints {
            $0.width.equalTo(200)
        }
        
        addSubview(loginInputStackView)
        
        loginInputStackView.snp.makeConstraints {
            $0.top.bottom.leading.bottom.equalToSuperview()
//            $0.height.equalTo(60)
        }
    }
}
