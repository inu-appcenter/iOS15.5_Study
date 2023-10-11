//
//  MemberDetailViewController.swift
//  MemberListApp
//
//  Created by 이대현 on 2023/10/11.
//

import UIKit

final class MemberDetailViewController: UIViewController {
    enum Mode {
        case create
        case update
    }
    
    let memberDetailPageMode: Mode
    var memberData: MemberData?
    
    private lazy var memberImageView: UIImageView = {
        let imageView = UIImageView()
        if let imageName = memberData?.imageName {
            imageView.image = UIImage(named: imageName)
        }
        imageView.backgroundColor = .gray
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var memberIDLabel: UILabel = {
        let label = UILabel()
        label.text = "멤버번호 : "
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    private lazy var memberIDTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "이름 : "
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var ageLabel: UILabel = {
        let label = UILabel()
        label.text = "나이 : "
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    private lazy var ageTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var phoneLabel: UILabel = {
        let label = UILabel()
        label.text = "전화번호 : "
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    private lazy var phoneTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.text = "주소 : "
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    private lazy var addressTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var submitButton: UIButton = {
        let button = UIButton()
        button.setTitle("UPDATE", for: .normal)
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(submitButtonTouched(_:)), for: .touchUpInside)
        return button
    }()
    
    @objc func submitButtonTouched(_ sender: Any) {
        guard let memberIdText = memberIDTextField.text,
              let memberId = Int(memberIdText),
              let name = nameTextField.text,
              let ageText = ageTextField.text,
              let age = Int(ageText),
              let phone = phoneTextField.text,
              let address = addressTextField.text else {
            return
        }
        let memberData = MemberData(memberID: memberId, name: name, age: age, phone: phone, address: address, imageName: name + ".png")
        MemberManager.shared.updateMember(data: memberData)
        self.navigationController?.popViewController(animated: true)
    }
    
    init(mode: Mode, data: MemberData?) {
        self.memberDetailPageMode = mode
        self.memberData = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        setupUI(mode: memberDetailPageMode, data: memberData)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        memberImageView.layer.cornerRadius = memberImageView.frame.height / 2
    }
    
    private func setupUI(mode: Mode, data: MemberData?) {
        switch mode {
        case .create:
            submitButton.setTitle("SAVE", for: .normal)
        case .update:
            submitButton.setTitle("UPDATE", for: .normal)
            if let data = data {
                memberIDTextField.text = String(data.memberID)
                nameTextField.text = data.name
                ageTextField.text = String(data.age)
                phoneTextField.text = data.phone
                addressTextField.text = data.address
            }
        }
    }
    
    private func layout() {
        self.view.backgroundColor = .systemBackground

        self.view.addSubview(memberImageView)
        memberImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(150)
        }
        
        self.view.addSubview(memberIDLabel)
        memberIDLabel.snp.makeConstraints { make in
            make.top.equalTo(memberImageView.snp.bottom).offset(50)
            make.left.equalToSuperview().offset(30)
            make.width.equalTo(50)
        }
        
        self.view.addSubview(memberIDTextField)
        memberIDTextField.snp.makeConstraints { make in
            make.centerY.equalTo(memberIDLabel)
            make.left.equalTo(memberIDLabel.snp.right).offset(10)
            make.right.equalToSuperview().offset(-30)
        }
        
        self.view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(memberIDLabel.snp.bottom).offset(30)
            make.left.equalTo(memberIDLabel)
            make.width.equalTo(memberIDLabel)
        }
        
        self.view.addSubview(nameTextField)
        nameTextField.snp.makeConstraints { make in
            make.centerY.equalTo(nameLabel)
            make.left.right.equalTo(memberIDTextField)
        }
        
        self.view.addSubview(ageLabel)
        ageLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(30)
            make.left.equalTo(nameLabel)
            make.width.equalTo(nameLabel)
        }
        
        self.view.addSubview(ageTextField)
        ageTextField.snp.makeConstraints { make in
            make.centerY.equalTo(ageLabel)
            make.left.right.equalTo(nameTextField)
        }
        
        self.view.addSubview(phoneLabel)
        phoneLabel.snp.makeConstraints { make in
            make.top.equalTo(ageLabel.snp.bottom).offset(30)
            make.left.equalTo(ageLabel)
            make.width.equalTo(ageLabel)
        }
        
        self.view.addSubview(phoneTextField)
        phoneTextField.snp.makeConstraints { make in
            make.centerY.equalTo(phoneLabel)
            make.left.right.equalTo(ageTextField)
        }
        
        
        self.view.addSubview(addressLabel)
        addressLabel.snp.makeConstraints { make in
            make.top.equalTo(phoneLabel.snp.bottom).offset(30)
            make.left.equalTo(phoneLabel)
            make.width.equalTo(phoneLabel)
        }
        
        self.view.addSubview(addressTextField)
        addressTextField.snp.makeConstraints { make in
            make.centerY.equalTo(addressLabel)
            make.left.right.equalTo(phoneTextField)
        }
        
        self.view.addSubview(submitButton)
        submitButton.snp.makeConstraints { make in
            make.top.equalTo(addressLabel.snp.bottom).offset(30)
            make.left.equalTo(addressLabel)
            make.right.equalTo(addressTextField)
            make.height.equalTo(30)
        }
    }
}
