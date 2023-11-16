//
//  UpdateMemberViewController.swift
//  MemberList
//
//  Created by Bowon Han on 10/8/23.

import UIKit

class UpdateMemberViewController:UIViewController{
    var updateMemberData: Member?
    var delegate: MemberDetailDelegate?
    
// MARK: - UI
    private let UpdateMemberNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "멤버번호"
        return label
    }()
    
    private let UpdateMemberNameLabel: UILabel = {
        let label = UILabel()
        label.text = "이       름"
        return label
    }()
    
    private let UpdateMemberAgeLabel: UILabel = {
        let label = UILabel()
        label.text = "나       이"
        return label
    }()

    private let UpdateMemberAddressLabel: UILabel = {
        let label = UILabel()
        label.text = "주       소"
        return label
    }()
    
    private let UpdateMemberPhoneNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "전화번호"
        return label
    }()
    
    var UpdateMemberImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    var UpdateMemberNumberTextField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 6
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 16.0, height: 0.0))
        textField.leftViewMode = .always
        return textField
    }()
    
    var UpdateMemberNameTextField:UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 6
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 16.0, height: 0.0))
        textField.leftViewMode = .always
        return textField
    }()
    
    var UpdateMemberAgeTextField:UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 6
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 16.0, height: 0.0))
        textField.leftViewMode = .always
        return textField
    }()
    
    var UpdateMemberAddressTextField:UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 6
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 16.0, height: 0.0))
        textField.leftViewMode = .always
        return textField
    }()
    
    var UpdateMemberPhoneNumberTextField:UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 6
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 16.0, height: 0.0))
        textField.leftViewMode = .always
        return textField
    }()
    
    lazy var UpdateMemberButton: UIButton = {
        let button = UIButton()
        button.setTitle("UPDATE", for: .normal)
        button.addTarget(self, action: #selector(onTapUpdateButton), for: .touchUpInside)
        button.backgroundColor = .systemGray
        button.layer.cornerRadius = 6
        return button
    }()

// MARK: - viewDidLoad
    override func viewDidLoad() {
        view.backgroundColor = .white
        setConstraint()
    }
    
// MARK: - action UpdateMemberButton
    @objc func onTapUpdateButton(_:UIButton){
        if var updatedMember = updateMemberData {
            updatedMember.memberNumber = UpdateMemberNumberTextField.text
            updatedMember.memberName = UpdateMemberNameTextField.text
            updatedMember.memberAge = UpdateMemberAgeTextField.text
            updatedMember.memberAddress = UpdateMemberAddressTextField.text
            updatedMember.memberPhoneNumber = UpdateMemberPhoneNumberTextField.text
            delegate?.didUpdateMember(updatedMember)
        }
        self.navigationController?.popViewController(animated: true)
    }

// MARK: - for constraint
    func setConstraint(){
        self.view.addSubview(UpdateMemberImageView)
        
        self.view.addSubview(UpdateMemberNumberLabel)
        self.view.addSubview(UpdateMemberNameLabel)
        self.view.addSubview(UpdateMemberAgeLabel)
        self.view.addSubview(UpdateMemberAddressLabel)
        self.view.addSubview(UpdateMemberPhoneNumberLabel)
        
        self.view.addSubview(UpdateMemberNumberTextField)
        self.view.addSubview(UpdateMemberNameTextField)
        self.view.addSubview(UpdateMemberAgeTextField)
        self.view.addSubview(UpdateMemberAddressTextField)
        self.view.addSubview(UpdateMemberPhoneNumberTextField)
        
        self.view.addSubview(UpdateMemberButton)
        
        UpdateMemberImageView.translatesAutoresizingMaskIntoConstraints = false
        
        UpdateMemberNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        UpdateMemberNameLabel.translatesAutoresizingMaskIntoConstraints = false
        UpdateMemberAgeLabel.translatesAutoresizingMaskIntoConstraints = false
        UpdateMemberAddressLabel.translatesAutoresizingMaskIntoConstraints = false
        UpdateMemberPhoneNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        
        UpdateMemberNumberTextField.translatesAutoresizingMaskIntoConstraints = false
        UpdateMemberNameTextField.translatesAutoresizingMaskIntoConstraints = false
        UpdateMemberAgeTextField.translatesAutoresizingMaskIntoConstraints = false
        UpdateMemberAddressTextField.translatesAutoresizingMaskIntoConstraints = false
        UpdateMemberPhoneNumberTextField.translatesAutoresizingMaskIntoConstraints = false
        
        UpdateMemberButton.translatesAutoresizingMaskIntoConstraints = false
        
        let safeArea = self.view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            UpdateMemberImageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 50),
            UpdateMemberImageView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 40),
            UpdateMemberImageView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -50),
            UpdateMemberImageView.widthAnchor.constraint(equalToConstant: 100),
            UpdateMemberImageView.heightAnchor.constraint(equalToConstant: 250),
            
            UpdateMemberNumberLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 40),
            UpdateMemberNumberLabel.topAnchor.constraint(equalTo: UpdateMemberImageView.bottomAnchor, constant: 40),
            
            UpdateMemberNameLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 40),
            UpdateMemberNameLabel.topAnchor.constraint(equalTo: UpdateMemberNumberLabel.bottomAnchor, constant: 40),
            
            UpdateMemberAgeLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 40),
            UpdateMemberAgeLabel.topAnchor.constraint(equalTo: UpdateMemberNameLabel.bottomAnchor, constant: 40),
            
            UpdateMemberAddressLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 40),
            UpdateMemberAddressLabel.topAnchor.constraint(equalTo: UpdateMemberAgeLabel.bottomAnchor, constant: 40),
            
            UpdateMemberPhoneNumberLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 40),
            UpdateMemberPhoneNumberLabel.topAnchor.constraint(equalTo: UpdateMemberAddressLabel.bottomAnchor, constant: 40),
            
            UpdateMemberNumberTextField.leadingAnchor.constraint(equalTo: UpdateMemberNumberLabel.trailingAnchor, constant: 30),
            UpdateMemberNumberTextField.topAnchor.constraint(equalTo: UpdateMemberImageView.bottomAnchor, constant: 30),
            UpdateMemberNumberTextField.widthAnchor.constraint(equalToConstant: 220),
            UpdateMemberNumberTextField.heightAnchor.constraint(equalToConstant: 40),
            
            UpdateMemberNameTextField.leadingAnchor.constraint(equalTo: UpdateMemberNameLabel.trailingAnchor, constant: 30),
            UpdateMemberNameTextField.topAnchor.constraint(equalTo: UpdateMemberNumberTextField.bottomAnchor, constant: 21),
            UpdateMemberNameTextField.widthAnchor.constraint(equalToConstant: 220),
            UpdateMemberNameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            UpdateMemberAgeTextField.leadingAnchor.constraint(equalTo: UpdateMemberAgeLabel.trailingAnchor, constant: 30),
            UpdateMemberAgeTextField.topAnchor.constraint(equalTo: UpdateMemberNameTextField.bottomAnchor, constant: 21),
            UpdateMemberAgeTextField.widthAnchor.constraint(equalToConstant: 220),
            UpdateMemberAgeTextField.heightAnchor.constraint(equalToConstant: 40),
            
            UpdateMemberAddressTextField.leadingAnchor.constraint(equalTo: UpdateMemberAddressLabel.trailingAnchor, constant: 30),
            UpdateMemberAddressTextField.topAnchor.constraint(equalTo: UpdateMemberAgeTextField.bottomAnchor, constant: 21),
            UpdateMemberAddressTextField.widthAnchor.constraint(equalToConstant: 220),
            UpdateMemberAddressTextField.heightAnchor.constraint(equalToConstant: 40),
            
            UpdateMemberPhoneNumberTextField.leadingAnchor.constraint(equalTo: UpdateMemberPhoneNumberLabel.trailingAnchor, constant: 30),
            UpdateMemberPhoneNumberTextField.topAnchor.constraint(equalTo: UpdateMemberAddressTextField.bottomAnchor, constant: 21),
            UpdateMemberPhoneNumberTextField.widthAnchor.constraint(equalToConstant: 220),
            UpdateMemberPhoneNumberTextField.heightAnchor.constraint(equalToConstant: 40),
            
            UpdateMemberButton.topAnchor.constraint(equalTo: UpdateMemberPhoneNumberTextField.bottomAnchor,constant: 30),
            UpdateMemberButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,constant: 40),
            UpdateMemberButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -40),
            UpdateMemberButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -60),
            UpdateMemberButton.widthAnchor.constraint(equalToConstant: 313),
            UpdateMemberButton.heightAnchor.constraint(equalToConstant: 47)
        ])
    }
}
