//
//  AddMemberViewController.swift
//  MemberList
//
//  Created by Bowon Han on 10/8/23.
//

import UIKit

class AddMemberViewController:UIViewController{
    private let AddMemberNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "멤버번호"
        return label
    }()
    
    private let AddMemberNameLabel: UILabel = {
        let label = UILabel()
        label.text = "이       름"
        return label
    }()
    
    private let AddMemberAgeLabel: UILabel = {
        let label = UILabel()
        label.text = "나       이"
        return label
    }()

    private let AddMemberAddressLabel: UILabel = {
        let label = UILabel()
        label.text = "주       소"
        return label
    }()
    
    private let AddMemberPhoneNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "전화번호"
        return label
    }()
    
    let AddMemberImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = imageView.frame.height/2
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let AddMemberNumberTextField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 6
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 16.0, height: 0.0))
        textField.leftViewMode = .always
        return textField
    }()
    
    let AddMemberNameTextField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 6
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 16.0, height: 0.0))
        textField.leftViewMode = .always
        return textField
    }()
    
    let AddMemberAgeTextField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 6
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 16.0, height: 0.0))
        textField.leftViewMode = .always
        return textField
    }()
    
    let AddMemberAddressTextField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 6
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 16.0, height: 0.0))
        textField.leftViewMode = .always
        return textField
    }()
            
    let AddMemberPhoneNumberTextField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 6
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 16.0, height: 0.0))
        textField.leftViewMode = .always
        return textField
    }()
    
    lazy var AddMemberButton: UIButton = {
        let button = UIButton()
        button.setTitle("ADD", for: .normal)
        button.backgroundColor = .systemGray
        button.layer.cornerRadius = 6
        button.addTarget(self, action: #selector(onTapAddButton), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        setConstraint()
    }
        
    @objc func onTapAddButton(_:UIButton){
        var memberData: Member

        memberData = Member(memberImage: "배트맨.png", memberNumber: AddMemberNumberTextField.text, memberName: AddMemberNameTextField.text, memberAge: AddMemberAgeTextField.text, memberPhoneNumber: AddMemberPhoneNumberTextField.text, memberAddress: AddMemberAddressTextField.text)
        memberList.append(memberData)

        self.navigationController?.popViewController(animated: true)
    }
        
    func setConstraint(){
        self.view.addSubview(AddMemberImageView)
        
        self.view.addSubview(AddMemberNumberLabel)
        self.view.addSubview(AddMemberNameLabel)
        self.view.addSubview(AddMemberAgeLabel)
        self.view.addSubview(AddMemberAddressLabel)
        self.view.addSubview(AddMemberPhoneNumberLabel)
        
        self.view.addSubview(AddMemberNumberTextField)
        self.view.addSubview(AddMemberNameTextField)
        self.view.addSubview(AddMemberAgeTextField)
        self.view.addSubview(AddMemberAddressTextField)
        self.view.addSubview(AddMemberPhoneNumberTextField)
        
        self.view.addSubview(AddMemberButton)
        
        AddMemberImageView.translatesAutoresizingMaskIntoConstraints = false
                
        AddMemberNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        AddMemberNameLabel.translatesAutoresizingMaskIntoConstraints = false
        AddMemberAgeLabel.translatesAutoresizingMaskIntoConstraints = false
        AddMemberAddressLabel.translatesAutoresizingMaskIntoConstraints = false
        AddMemberPhoneNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        
        AddMemberNumberTextField.translatesAutoresizingMaskIntoConstraints = false
        AddMemberNameTextField.translatesAutoresizingMaskIntoConstraints = false
        AddMemberAgeTextField.translatesAutoresizingMaskIntoConstraints = false
        AddMemberAddressTextField.translatesAutoresizingMaskIntoConstraints = false
        AddMemberPhoneNumberTextField.translatesAutoresizingMaskIntoConstraints = false
        
        AddMemberButton.translatesAutoresizingMaskIntoConstraints = false
        
        let safeArea = self.view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            //imageview constraint
            AddMemberImageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 50),
            AddMemberImageView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 40),
            AddMemberImageView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -50),
            AddMemberImageView.widthAnchor.constraint(equalToConstant: 100),
            AddMemberImageView.heightAnchor.constraint(equalToConstant: 250),
            
            //label constraint
            AddMemberNumberLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 40),
            AddMemberNumberLabel.topAnchor.constraint(equalTo: AddMemberImageView.bottomAnchor, constant: 40),
            
            AddMemberNameLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 40),
            AddMemberNameLabel.topAnchor.constraint(equalTo: AddMemberNumberLabel.bottomAnchor, constant: 40),
            
            AddMemberAgeLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 40),
            AddMemberAgeLabel.topAnchor.constraint(equalTo: AddMemberNameLabel.bottomAnchor, constant: 40),
            
            AddMemberAddressLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 40),
            AddMemberAddressLabel.topAnchor.constraint(equalTo: AddMemberAgeLabel.bottomAnchor, constant: 40),
            
            AddMemberPhoneNumberLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 40),
            AddMemberPhoneNumberLabel.topAnchor.constraint(equalTo: AddMemberAddressLabel.bottomAnchor, constant: 40),
            
            //textfield constraint
            AddMemberNumberTextField.leadingAnchor.constraint(equalTo: AddMemberNumberLabel.trailingAnchor, constant: 30),
            AddMemberNumberTextField.topAnchor.constraint(equalTo: AddMemberImageView.bottomAnchor, constant: 30),
            AddMemberNumberTextField.widthAnchor.constraint(equalToConstant: 220),
            AddMemberNumberTextField.heightAnchor.constraint(equalToConstant: 40),
            
            AddMemberNameTextField.leadingAnchor.constraint(equalTo: AddMemberNameLabel.trailingAnchor, constant: 30),
            AddMemberNameTextField.topAnchor.constraint(equalTo: AddMemberNumberTextField.bottomAnchor, constant: 21),
            AddMemberNameTextField.widthAnchor.constraint(equalToConstant: 220),
            AddMemberNameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            AddMemberAgeTextField.leadingAnchor.constraint(equalTo: AddMemberAgeLabel.trailingAnchor, constant: 30),
            AddMemberAgeTextField.topAnchor.constraint(equalTo: AddMemberNameTextField.bottomAnchor, constant: 21),
            AddMemberAgeTextField.widthAnchor.constraint(equalToConstant: 220),
            AddMemberAgeTextField.heightAnchor.constraint(equalToConstant: 40),
            
            AddMemberAddressTextField.leadingAnchor.constraint(equalTo: AddMemberAddressLabel.trailingAnchor, constant: 30),
            AddMemberAddressTextField.topAnchor.constraint(equalTo: AddMemberAgeTextField.bottomAnchor, constant: 21),
            AddMemberAddressTextField.widthAnchor.constraint(equalToConstant: 220),
            AddMemberAddressTextField.heightAnchor.constraint(equalToConstant: 40),
            
            AddMemberPhoneNumberTextField.leadingAnchor.constraint(equalTo: AddMemberPhoneNumberLabel.trailingAnchor, constant: 30),
            AddMemberPhoneNumberTextField.topAnchor.constraint(equalTo: AddMemberAddressTextField.bottomAnchor, constant: 21),
            AddMemberPhoneNumberTextField.widthAnchor.constraint(equalToConstant: 220),
            AddMemberPhoneNumberTextField.heightAnchor.constraint(equalToConstant: 40),
            
            //button constraint
            AddMemberButton.topAnchor.constraint(equalTo: AddMemberPhoneNumberTextField.bottomAnchor,constant: 30),
            AddMemberButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,constant: 40),
            AddMemberButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -40),
            AddMemberButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -60),
            AddMemberButton.widthAnchor.constraint(equalToConstant: 313),
            AddMemberButton.heightAnchor.constraint(equalToConstant: 47)
        ])
    }
}

