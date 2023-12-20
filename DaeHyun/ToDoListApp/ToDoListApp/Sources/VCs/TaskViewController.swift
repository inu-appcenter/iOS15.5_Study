//
//  TaskViewController.swift
//  ToDoListApp
//
//  Created by 이대현 on 2023/11/08.
//

import Moya
import SnapKit
import UIKit

enum FetchMode {
    case server
    case coredata
}

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
                let section: TodoSection
                if self.todayButton.isSelected {
                    section = .Today
                } else {
                    section = .Upcoming
                }
                appendTaskData(title: content, at: section, mode: .server)
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
    
    var todayTaskData: [Todo] = []
    
    var upcomingTaskData: [Todo] = []
    
    // 서버 통신을 위한 provider
    let provider = MoyaProvider<TodoAPI>()
    // fetch mode
    let fetchMode: FetchMode = .server
    
    private lazy var taskTableViewDiffableDataSource: UITableViewDiffableDataSource<TodoSection, Todo> = {
        let diffableDataSource = UITableViewDiffableDataSource<TodoSection, Todo>(
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
    
    private lazy var taskTableViewSnapShot = NSDiffableDataSourceSnapshot<TodoSection, Todo>()

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        fetchTaskData(at: .server)
        loadTableView()
    }
    
    private func fetchTaskData(at mode: FetchMode = .coredata) {
        switch mode {
        case .coredata:
            // 코어데이터 저장소에서 가져옴
            if let taskData = TaskManager.shared.fetchTaskData(key: "today") {
                self.todayTaskData = taskData
            }
            if let taskData = TaskManager.shared.fetchTaskData(key: "upcoming") {
                self.upcomingTaskData = taskData
            }
        case .server:
            // 서버 api 통신을 통해 가져옴
            provider.request(.getList) { result in
                switch result {
                case let .success(response):
                    print(String(data: response.data, encoding: .utf8))
                    if let result = try? response.map([TodoResponseDTO].self) {
                        // todo list에서 deadline이 오늘까지인지 아닌지로
                        // 섹션 분류 후 보여줌
                        // 과거 deadline의 todo도 today에 들어가긴 합니다
                        self.todayTaskData = result
                            .map { $0.toTodo() }
                            .filter { $0.deadLine.isToday }
                        self.upcomingTaskData = result
                            .map { $0.toTodo() }
                            .filter { !$0.deadLine.isToday }
                        self.loadTableView()
                    }
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    private func appendTaskData(title: String,
                                at section: TodoSection,
                                mode: FetchMode = .coredata) {
        // deadline
        // today -> 그 날의 23시 59분, upcoming -> 다음 날
        let deadLine = section == .Today ? Date().endOfDay : Date().tomorrow
        
        switch mode {
        case .coredata:
            // 코어데이터 저장
            let task = Todo(
               id: UUID().uuidString,
               name: title,
               isCompleted: false,
               deadLine: deadLine
           )
            if section == .Today {
                self.todayTaskData.append(task)
                TaskManager.shared.saveTaskData(data: self.todayTaskData, key: "today")
            } else {
                self.upcomingTaskData.append(task)
                TaskManager.shared.saveTaskData(data: self.upcomingTaskData, key: "upcoming")
            }
            self.loadTableView()
        case .server:
            // 서버 api 활용
            let requestBody = TodoRequestDTO(
                content: title, // content도 일단 title로 설정
                deadLine: deadLine.toString,
                title: title
            )
            provider.request(.createTodo(requestBody)) { result in
                switch result {
                case let .success(response):
                    print(String(data: response.data, encoding: .utf8))
                    if let result = try? response.map(TodoResponseDTO.self) {
                        let task = Todo(id: String(result.id),
                                        name: result.title,
                                        isCompleted: result.isCompleted,
                                        deadLine: result.deadLineDate)
                        if section == .Today {
                            self.todayTaskData.append(task)
                        } else {
                            self.upcomingTaskData.append(task)
                        }
                        self.loadTableView()
                    }
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    private func updateIsCompleted(_ id: Int, _ completed: Bool) {
        provider.request(.updateCheck(id, completed)) { result in
            switch result {
            case let .success(response):
                print(String(data: response.data, encoding: .utf8))
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func removeTaskDate(_ id: Int) {
        provider.request(.deleteTodo(id)) { result in
            switch result {
            case .success:
                print("ID: \(id) - Todo 삭제 성공")
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func loadTableView() {
        taskTableViewSnapShot = NSDiffableDataSourceSnapshot<TodoSection, Todo>()
        taskTableViewSnapShot.appendSections([.Today, .Upcoming])
        populateSnapshot(data: todayTaskData, to: .Today)
        populateSnapshot(data: upcomingTaskData, to: .Upcoming)
        taskTableViewDiffableDataSource.apply(taskTableViewSnapShot)
    }
    
    private func populateSnapshot(data: [Todo], to section: TodoSection) {
        taskTableViewSnapShot.appendItems(data, toSection: section)
    }
    
    
    private func layout() {
        
        self.view.addSubview(appendStackView)
        appendStackView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        self.view.addSubview(taskTableView)
        taskTableView.snp.makeConstraints { make in
            make.left.right.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(appendStackView.snp.top)
        }
    }
}

extension TaskViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: TaskHeaderView.identifier) as? TaskHeaderView else {
            return UIView()
        }
        if section == TodoSection.Today.rawValue {
            headerView.setTitle("Today")
        } else {
            headerView.setTitle("Upcoming")
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    
    // MARK: - TaskDetailViewController 화면전환
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("select row")
        var task: Todo
        if indexPath.section == 0 {
            task = todayTaskData[indexPath.row]
        } else {
            task = upcomingTaskData[indexPath.row]
        }
        if let id = Int(task.id) {
            let vc = TaskDetailViewController()
            vc.setupUI(id: id)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension TaskViewController: TaskTableViewCellDelegate {
    func setIsComplete(forCell cell: TaskTableViewCell, _ isComplete: Bool) {
        if let indexPath = taskTableView.indexPath(for: cell) {
            var task: Todo
            if indexPath.section == 0 {
                task = todayTaskData[indexPath.row]
            } else {
                task = upcomingTaskData[indexPath.row]
            }
            task.isCompleted = isComplete
            if let id = Int(task.id) {
                updateIsCompleted(id, isComplete)
            }
        }
    }
    
    
    func removeTask(forCell cell: TaskTableViewCell) {
        if let indexPath = taskTableView.indexPath(for: cell) {
            let task: Todo
            if indexPath.section == 0 {
                task = todayTaskData.remove(at: indexPath.row)
            } else {
                task = upcomingTaskData.remove(at: indexPath.row)
            }
            if fetchMode == .coredata {
                if indexPath.section == 0 {
                    TaskManager.shared.saveTaskData(data: self.todayTaskData, key: "today")
                } else {
                    TaskManager.shared.saveTaskData(data: self.upcomingTaskData, key: "upcoming")
                }
            } else {
                if let id = Int(task.id) {
                    removeTaskDate(id)
                }
            }
            loadTableView()
        }
    }
}
