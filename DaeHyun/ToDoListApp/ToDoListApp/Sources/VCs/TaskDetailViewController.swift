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
    var todoID: Int? = nil
    // 서버 통신을 위한 provider
    let provider = MoyaProvider<TodoAPI>()
    
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
        textView.font = .systemFont(ofSize: 16)
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
        button.addAction(UIAction { [weak self] _ in
            if let self = self,
               let id = self.todoID,
               let title = self.titleTextField.text,
               let content = self.descriptionTextView.text {
                let deadline = self.deadlineDatePicker.date
                
                // todo server api
                let todoRequest = TodoRequestDTO(
                    content: content,
                    deadLine: deadline.toString,
                    title: title
                )
                provider.request(.updateTodo(id, todoRequest)) { [weak self] result in
                    switch result {
                    case let .success(response):
                        print(String(data: response.data, encoding: .utf8))
                        self?.backToTodoListView()
                    case let .failure(error):
                        print(error.localizedDescription)
                    }
                }
                
            }
        }, for: .touchUpInside)
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
            make.top.equalTo(deadlineDatePicker.snp.bottom).offset(20)
            make.height.equalTo(50)
        }
    }
    
    // MARK: - 초기 세팅
    func setupUI(id: Int) {
        self.todoID = id

        _Concurrency.Task {
            let result = await provider.request(.getDetail(id))
            switch result {
            case let .success(response):
                print(String(data: response.data, encoding: .utf8))
                if let result = try? response.map(TodoResponseDTO.self) {
                    let todoData = result.toTodo()
                    // 여기서 UI 세팅
                    DispatchQueue.main.async {
                        self.titleTextField.text = todoData.name
                        self.descriptionTextView.text = todoData.content
                        self.deadlineDatePicker.date = todoData.deadLine
                    }
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
    
    func backToTodoListView() {
        self.navigationController?.popViewController(animated: true)
    }
}
