//
//  RegisterView.swift
//  TodoAPP_project
//
//  Created by Bowon Han on 11/26/23.
//

import UIKit
import SnapKit

protocol PlusListButtonDelegate : AnyObject {
    func tabAddTodoButton(forView view: RegisterView)
}

final class RegisterView : UIView {
    weak var delegate : PlusListButtonDelegate?
    
    private lazy var registerStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.backgroundColor = .darkGreen
    
        return stackView
    }()
    
    let registerTextField : UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.setContentHuggingPriority(.defaultLow, for: .horizontal)
        textField.setContentHuggingPriority(.defaultLow, for: .vertical)
        textField.clearButtonMode = .always
        textField.placeholder = "I want to ..."
        
        return textField
    }()
    
    lazy var addTodoButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        button.tintColor = .systemGray6
        button.addTarget(self, action: #selector(tabAddTodoButton), for: .touchUpInside)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setStackViewLayout()
        setLayout()
        registerTextField.delegate = self
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @objc private func tabAddTodoButton(_:UIButton){
        delegate?.tabAddTodoButton(forView: self)
        self.registerTextField.endEditing(true)
    }

    private func setStackViewLayout(){
        [registerTextField,addTodoButton].forEach {
            registerStackView.addArrangedSubview($0)
        }
        registerStackView.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: .zero, right: 10)
        registerStackView.isLayoutMarginsRelativeArrangement = true
    }
    
    private func setLayout() {        
        addTodoButton.snp.makeConstraints {
            $0.width.greaterThanOrEqualTo(50)
        }
        
        addSubview(registerStackView)

        registerStackView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(70)
        }
    }
}

// MARK: - UITextFieldDelegate extension
extension RegisterView : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
