//
//  TaskDetailViewController.swift
//  ToDoListApp
//
//  Created by 이대현 on 12/20/23.
//

import Moya
import SnapKit
import UIKit

class TaskDetailViewController: UIViewController {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "제목"
        return label
    }()
    
    private lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.text = "titletitle"
        return textField
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "내용"
        return label
    }()
    
    private lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 1
        textView.text = "description"
        return textView
    }()
    
    private lazy var deadlineLabel: UILabel = {
        let label = UILabel()
        label.text = "마감일"
        return label
    }()
    
    private lazy var deadlineDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .compact
        datePicker.locale = Locale(identifier: "ko-KR")
        return datePicker
    }()
    
    private lazy var updateButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .red
        config.baseForegroundColor = .black
        config.title = "수정하기"
        
        let button = UIButton(configuration: config)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }
    
    private func layout() {
        self.view.backgroundColor = .systemBackground
        
        self.view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-30)
        }
        
        self.view.addSubview(titleTextField)
        titleTextField.snp.makeConstraints { make in
            make.left.right.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom           ).offset(20)
        }
        
        self.view.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.left.right.equalTo(titleTextField)
            make.top.equalTo(titleTextField.snp.bottom           ).offset(20)
        }
        
        self.view.addSubview(descriptionTextView)
        descriptionTextView.snp.makeConstraints { make in
            make.left.right.equalTo(descriptionLabel)
            make.top.equalTo(descriptionLabel.snp.bottom           ).offset(20)
            make.height.equalTo(150)
        }
        
        self.view.addSubview(deadlineLabel)
        deadlineLabel.snp.makeConstraints { make in
            make.left.right.equalTo(descriptionTextView)
            make.top.equalTo(descriptionTextView.snp.bottom           ).offset(20)
        }
        
        self.view.addSubview(deadlineDatePicker)
        deadlineDatePicker.snp.makeConstraints { make in
            make.left.equalTo(deadlineLabel)
            make.top.equalTo(deadlineLabel.snp.bottom).offset(20)
        }
        
        self.view.addSubview(updateButton)
        updateButton.snp.makeConstraints { make in
            make.left.right.equalTo(deadlineLabel)
            make.top.equalTo(deadlineLabel.snp.bottom).offset(20)
            make.height.equalTo(50)
        }
    }
}
