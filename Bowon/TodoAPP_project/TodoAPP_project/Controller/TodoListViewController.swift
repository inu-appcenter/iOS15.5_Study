//
//  TodoListViewController.swift
//  TodoAPP_project
//
//  Created by Bowon Han on 11/26/23.
//

import UIKit
import SnapKit

class TodoListViewController: UIViewController {
    private let saveData = Networks.shared
    
    let scrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setLayout()
        configureTableView()
        configureScrollViewInset()
        fetchAllTodoList(2)

    }
    
    func fetchAllTodoList(_ id: Int) {
        guard let url = URL(string: "http://hyeseong.na2ru2.me/api/members/tasks/\(id)") else { return }
    
        Task {
            do {
                let todoInformation = try await saveData.fetchTodoInfo(url: url)
                saveData.todoDataSource = todoInformation
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                print(saveData.todoDataSource)
            } catch {
                print("Error: \(error)")
            }
        }
    }

// MARK: - UI
    private lazy var tableView : UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
    
        return tableView
    }()
    
    private lazy var registerView: RegisterView = {
        let view = RegisterView()
        view.delegate = self

        return view
    }()
        
// MARK: - layout
    private func setLayout() {
        view.addSubview(tableView)
        view.addSubview(registerView)
        
        tableView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        registerView.snp.makeConstraints {
            $0.bottom.equalTo(self.view.keyboardLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(60)
        }
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TodoTableViewCell.self, forCellReuseIdentifier: TodoTableViewCell.identifier)
    }
    
    private func configureScrollViewInset() {
        if let tabBarHeight = tabBarController?.tabBar.frame.size.height {
            let insets = UIEdgeInsets(top: 0, left: 0, bottom: tabBarHeight, right: 0)
            tableView.contentInset = insets
            tableView.scrollIndicatorInsets = insets
        }
    }
}

// MARK: - UITableView extension
extension TodoListViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let todoData = saveData.todoDataSource[indexPath.row]

        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: TodoTableViewCell.identifier,
            for: indexPath
        ) as? TodoTableViewCell else {
            return UITableViewCell()
        }
        
        cell.prepareLabel(
            todoListLabel:todoData.title
        )
        
        cell.delegate = self
        cell.selectionStyle = .none
        
        let successOrNot = todoData.isFinished
        
        if let successOrNot = successOrNot {
            if successOrNot {
                cell.complete()
            }
            else {
                cell.unComplete()
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return saveData.todoDataSource.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let todoData = saveData.todoDataSource[indexPath.row]

        let detailVC = DetailViewController()
        detailVC.detailViewListName.text = todoData.title
        detailVC.indexNumber = indexPath.row
        
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let id = saveData.todoDataSource[indexPath.row].id
            saveData.deleteTodoList(id)
            saveData.todoDataSource.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let todoTableViewHeaderView = SectionHeaderView()
        
        return todoTableViewHeaderView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let todoTableViewHeaderView = SectionHeaderView()
        
        let intrinsicHeight = todoTableViewHeaderView.intrinsicContentSize.height
        
        return intrinsicHeight
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

// MARK: - ButtonTappedDelegate extension
extension TodoListViewController : ButtonTappedDelegate {
    func tapFinishButton(forCell cell: TodoTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
                
        let cellData = saveData.todoDataSource[indexPath.row]
        let id = cellData.id
        let title = cellData.title
        
        var currentIndexDate : String?
        
        if let currentIndexDate = cellData.endDate?.toString() { }
        
        //if let description = cellData.description {}
        
        if let successOrNot = cellData.isFinished {
            if !successOrNot {
                print(id,title,successOrNot)

                cell.complete()
                saveData.todoDataSource[indexPath.row].isFinished = true
                saveData.modifyTodoList(title: title, description: "l", isFinished: true, endDate: currentIndexDate ?? "2023-12-01", id: id)
            }
            
            else {
                print(id,title,successOrNot)

                cell.unComplete()
                saveData.todoDataSource[indexPath.row].isFinished = false
                saveData.modifyTodoList(title: title, description: "l", isFinished: false, endDate: currentIndexDate ?? "2023-12-01", id: id)
            }
        }
    }
    
    func tapDeleteButton(forCell cell: TodoTableViewCell) {
        if let indexPath = tableView.indexPath(for: cell),
           indexPath.section < saveData.todoDataSource.count {
            let id = saveData.todoDataSource[indexPath.row].id
            saveData.deleteTodoList(id)
            saveData.todoDataSource.remove(at: indexPath.row)
                
            tableView.deleteRows(at: [indexPath], with: .fade)
                
            cell.checkButton.setImage(UIImage(systemName: "circle"), for: .normal)
            cell.todoListLabel.textColor = .black
            cell.todoListLabel.unsetStrikethrough(from: cell.todoListLabel.text, at: cell.todoListLabel.text)
                
            cell.deleteButton.setImage(nil, for: .normal)
        }
    }
}

// MARK: - PlusListButtonDelegate extension
extension TodoListViewController : PlusListButtonDelegate {    
    func tabAddTodoButton(forView view: RegisterView) {
        if let text = view.registerTextField.text, !text.isEmpty {
            let date = Date.now
            let dateToString = date.toString()
            
            saveData.createTodoList(title: text, description: " ", endDate: dateToString, id: 2)
            fetchAllTodoList(2)
            
            view.registerTextField.text = ""
        }
    }
}


