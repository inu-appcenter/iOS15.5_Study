//
//  TaskViewController.swift
//  ToDoListApp
//
//  Created by 이대현 on 2023/11/08.
//

import SnapKit
import UIKit

class TaskViewController: UIViewController {
    private lazy var taskTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TaskTableViewCell.self, forCellReuseIdentifier: TaskTableViewCell.identifier)
        tableView.register(TaskHeaderView.self, forHeaderFooterViewReuseIdentifier: TaskHeaderView.identifier)
        tableView.delegate = self
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
        button.setTitleColor(.black, for: .selected )
        button.addAction(UIAction { [weak self] _ in
            button.isSelected.toggle()
        }, for: .touchUpInside)
        return button
    }()
    
    private lazy var addButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .systemGray5
        config.baseForegroundColor = .black
        config.image = UIImage(systemName: "plus")
        
        let button = UIButton(configuration: config)
        button.addAction(UIAction { [weak self] _ in
            if let self = self,
               let content = self.taskTextField.text {
                if self.todayButton.isSelected {
                    self.todayTaskData.append(Task(name: content, isComplete: false))
                } else {
                    self.upcomingTaskData.append(Task(name: content, isComplete: false))
                }
                self.loadTableView()
            }
        }, for: .touchUpInside)
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
    
    var todayTaskData: [Task] = [
        Task(name: "today walking", isComplete: false),
        Task(name: "walking", isComplete: false),
        Task(name: "walking", isComplete: true),
        Task(name: "walking", isComplete: false),
        Task(name: "walking", isComplete: false),
    ]
    
    var upcomingTaskData: [Task] = [
        Task(name: "upcoming walking", isComplete: false),
        Task(name: "walking", isComplete: true),
        Task(name: "walking", isComplete: false),
        Task(name: "walking", isComplete: false),
        Task(name: "walking", isComplete: false),
    ]
    
    private lazy var taskTableViewDiffableDataSource: UITableViewDiffableDataSource<TaskSection, Task> = {
        let diffableDataSource = UITableViewDiffableDataSource<TaskSection, Task>(
            tableView: taskTableView
        ) { tableView, _, task -> UITableViewCell? in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.identifier) as? TaskTableViewCell
            else {
                return UITableViewCell()
            }
            cell.delegate = self
            cell.setupUI(task: task)
            return cell
        }
        return diffableDataSource
    }()
    
    private lazy var taskTableViewSnapShot = NSDiffableDataSourceSnapshot<TaskSection, Task>()

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        fetchTaskData()
        loadTableView()
    }
    
    private func fetchTaskData() {
        if let todayTaskData = UserDefaults.standard.object(forKey: "today") as? Data{
            let decoder = JSONDecoder()
            if let todayTasks = try? decoder.decode([Task].self, from: todayTaskData) {
                self.todayTaskData = todayTasks
            }
        }
        
        if let upcomingTaskData = UserDefaults.standard.object(forKey: "upcoming") as? Data{
            let decoder = JSONDecoder()
            if let upcomingTasks = try? decoder.decode([Task].self, from: upcomingTaskData) {
                self.upcomingTaskData = upcomingTasks
            }
        }
    }
    
    private func loadTableView() {
        taskTableViewSnapShot = NSDiffableDataSourceSnapshot<TaskSection, Task>()
        taskTableViewSnapShot.appendSections([.Today, .Upcoming])
        populateSnapshot(data: todayTaskData, to: .Today)
        populateSnapshot(data: upcomingTaskData, to: .Upcoming)
    }
    
    private func populateSnapshot(data: [Task], to section: TaskSection) {
        taskTableViewSnapShot.appendItems(data, toSection: section)
        taskTableViewDiffableDataSource.apply(taskTableViewSnapShot)
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
    
    func saveTaskData() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(todayTaskData) {
            UserDefaults.standard.setValue(encoded, forKey: "today")
        }
        
        if let encoded = try? encoder.encode(upcomingTaskData) {
            UserDefaults.standard.setValue(encoded, forKey: "upcoming")
        }
    }
}

extension TaskViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: TaskHeaderView.identifier) as? TaskHeaderView else {
            return UIView()
        }
        if section == TaskSection.Today.rawValue {
            headerView.setTitle("Today")
        } else {
            headerView.setTitle("Upcoming")
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
}

extension TaskViewController: TaskTableViewCellDelegate {
    func removeTask(forCell cell: TaskTableViewCell) {
        if let indexPath = taskTableView.indexPath(for: cell) {
            if indexPath.section == 0 {
                todayTaskData.remove(at: indexPath.row)
            } else {
                upcomingTaskData.remove(at: indexPath.row)
            }
            loadTableView()
        }
    }
}
