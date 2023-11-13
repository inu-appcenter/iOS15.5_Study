//
//  TaskViewController.swift
//  ToDoListApp
//
//  Created by 이대현 on 2023/11/08.
//

import SnapKit
import UIKit

class TaskViewController: UIViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("TaskViewController touched")
    }
    private lazy var taskTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TaskTableViewCell.self, forCellReuseIdentifier: TaskTableViewCell.identifier)
        return tableView
    }()
    
    private lazy var taskTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "I want to..."
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var todayButton: UIButton = {
        let button = UIButton()
        button.setTitle("today", for: .normal)
        button.setTitleColor(.systemGray2, for: .normal)
        return button
    }()
    
    private lazy var addButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .systemGray5
        config.baseForegroundColor = .black
        config.image = UIImage(systemName: "plus")
        
        let button = UIButton(configuration: config)
        return button
    }()
    
    private lazy var appendStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [taskTextField, todayButton, addButton])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
        stackView.backgroundColor = .systemGray5
        return stackView
    }()
    
    private let sections = ["Today", "Upcoming"]

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        // Do any additional setup after loading the view.
    }
    private func layout() {
        
        self.view.addSubview(appendStackView)
        appendStackView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(70)
        }
        
        self.view.addSubview(taskTableView)
        taskTableView.snp.makeConstraints { make in
            make.left.right.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(appendStackView.snp.top)
        }
    }
}

extension TaskViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.identifier) as? TaskTableViewCell
        else {
            return UITableViewCell()
        }
        cell.setupUI()
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textColor = UIColor.black
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 34)
        header.textLabel?.frame = header.bounds
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
}
