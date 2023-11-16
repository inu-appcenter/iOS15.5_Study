//
//  TodoListViewController.swift
//  TodoUI
//
//  Created by Bowon Han on 11/5/23.
//

// configuration

import UIKit
import SnapKit

class TodoListViewController: UIViewController {
    private let saveData = SaveData.shared
    
    var bottomConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setLayout()
        configureTableView()
        setUp()
        keyboardLayout()
        saveData.loadAllData()
    
        self.view.gestureRecognizers?.removeAll()
    }
    
// MARK: - keyboard
    override func viewWillAppear(_ animated: Bool) {
        self.addKeyboardNotifications()
        tableView.reloadData()
    }
        
    override func viewWillDisappear(_ animated: Bool) {
        self.removeKeyboardNotifications()
        saveData.saveAllData()
    }
    
    func keyboardLayout() {
        let safeArea = self.view.safeAreaLayoutGuide
            
        self.bottomConstraint = NSLayoutConstraint(item: self.registerView, attribute: .bottom, relatedBy: .equal, toItem: safeArea, attribute: .bottom, multiplier: 1.0, constant: 0)
        self.bottomConstraint?.isActive = true
    }
        
    func addKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification , object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ noti: NSNotification) {
        if let keyboardSize = (noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight: CGFloat
            keyboardHeight = keyboardSize.height - self.view.safeAreaInsets.bottom
            self.bottomConstraint?.constant = -1 * keyboardHeight
            self.view.layoutIfNeeded()
        }
    }

    @objc func keyboardWillHide(_ noti: NSNotification) {
        if let keyboardFrame: NSValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            self.bottomConstraint?.constant = keyboardHeight
            self.view.layoutIfNeeded()
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

// MARK: -  초기 data
    private func setUp() {
        let todayModels = [
            TodoListModel(success: false, todoNameLabel: "study",startDate: nil, deadlineDate: nil),
        ]
        let todaySection = SettingSection.init(list: todayModels, sectionName: "Today")
        
        let upcomingModels = [
            TodoListModel(success: false, todoNameLabel: "exercise",startDate: nil, deadlineDate: nil),
            TodoListModel(success: false, todoNameLabel: "work",startDate: nil, deadlineDate: nil),
        ]
        let upcomingSection = SettingSection.init(list: upcomingModels, sectionName: "Upcoming")
        
        saveData.dataSource = [todaySection,upcomingSection]
        self.tableView.reloadData()
    }
        
// MARK: - layout
    private func setLayout() {
        view.addSubview(tableView)
        view.addSubview(registerView)
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.bottom.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(5)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-5)
        }
        
        registerView.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(70)
        }
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TodoTableViewCell.self, forCellReuseIdentifier: TodoTableViewCell.identifier)
        tableView.register(TodoTableViewHeaderView.self, forHeaderFooterViewReuseIdentifier: TodoTableViewHeaderView.identifier)
    }
}

// MARK: - UITableView extension
extension TodoListViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionData = saveData.dataSource[indexPath.section]
                
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: TodoTableViewCell.identifier,
            for: indexPath
        ) as? TodoTableViewCell else {
            fatalError("Failed to dequeue a cell.")
        }
        
        let todayModel = sectionData.list[indexPath.row]
        cell.prepare(
            todoListLabel:todayModel.todoNameLabel
        )
        cell.delegate = self
        cell.selectionStyle = .none
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        saveData.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionData = saveData.dataSource[section]
        
        return sectionData.list.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            var section = saveData.dataSource[indexPath.section]
            
            section.list.remove(at: indexPath.row)
            
            saveData.dataSource[indexPath.section] = section
            saveData.saveAllData()

            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionData = saveData.dataSource[section]

        guard let todoTableViewHeaderView = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: TodoTableViewHeaderView.identifier)
            as? TodoTableViewHeaderView else {
                    return UIView()
            }
        
        todoTableViewHeaderView.delegate = self
        todoTableViewHeaderView.sectionNameLabel.text = sectionData.sectionName
        
        return todoTableViewHeaderView
    }
}

// MARK: - ButtonTappedDelegate extension
extension TodoListViewController : ButtonTappedDelegate {
    func tapFinishButton(forCell cell: TodoTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) 
            else { return }
        
        let sectionIndex = indexPath.section
        let itemIndex = indexPath.row
        
        var successValue = saveData.dataSource[sectionIndex].list[itemIndex].success
        
        if !successValue {
            cell.checkButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            
            cell.todoListLabel.textColor = .lightGray
            cell.todoListLabel.strikethroughAndChangeLineColor(from: cell.todoListLabel.text, at: cell.todoListLabel.text)
            
            cell.deleteButton.setImage(UIImage(systemName: "multiply.circle.fill"), for: .normal)
            successValue = true
        }
        else {
            cell.checkButton.setImage(UIImage(systemName: "circle"), for: .normal)
            
            cell.todoListLabel.textColor = .black
            cell.todoListLabel.unsetStrikethrough(from: cell.todoListLabel.text, at: cell.todoListLabel.text)
            
            cell.deleteButton.setImage(nil, for: .normal)
            successValue = false
        }
    }
    
    func tapDeleteButton(forCell cell: TodoTableViewCell) {
        if let indexPath = tableView.indexPath(for: cell),
           indexPath.section < saveData.dataSource.count {
            var section = saveData.dataSource[indexPath.section]
            
            if indexPath.row < section.list.count {
                section.list.remove(at: indexPath.row)

                saveData.dataSource[indexPath.section] = section
                saveData.saveAllData()
                
                tableView.deleteRows(at: [indexPath], with: .fade)
                
                cell.checkButton.setImage(UIImage(systemName: "circle"), for: .normal)
                cell.todoListLabel.textColor = .black
                cell.todoListLabel.unsetStrikethrough(from: cell.todoListLabel.text, at: cell.todoListLabel.text)
                
                cell.deleteButton.setImage(nil, for: .normal)
            }
        }
    }
}

// MARK: - PlusListButtonDelegate extension
extension TodoListViewController : PlusListButtonDelegate {
    func tabAddTodoButton(forView view: RegisterView) {
        if let text = view.registerTextField.text, !text.isEmpty {
            let newTodo = TodoListModel(success: false, todoNameLabel: text,startDate: nil, deadlineDate: nil)
       
            if saveData.dataSource.isEmpty {
                let newSection = SettingSection(list: [newTodo], sectionName: "Today")
                saveData.dataSource.append(newSection)
                saveData.saveAllData()
            }
            else {
                if let sectionName = view.addTodoButton.title(for: .normal) {
                    if let sectionIndex = saveData.dataSource.firstIndex(where: { $0.sectionName == sectionName }) {
                        saveData.dataSource[sectionIndex].list.append(newTodo)
                        
                        saveData.saveAllData()
                        let newIndexPath = IndexPath(row: saveData.dataSource[sectionIndex].list.count - 1, section: sectionIndex)
                        tableView.insertRows(at: [newIndexPath], with: .none)
                    }
                }
            }
            view.registerTextField.text = ""
        }
    }
    
    func tabAddSectionButton(forView view: RegisterView) {
        if let text = view.registerTextField.text, !text.isEmpty {
            let newSection = SettingSection(list: [], sectionName: text)
            saveData.dataSource.append(newSection)
            saveData.saveAllData()
            
            let sectionIndex = saveData.dataSource.count - 1
            tableView.insertSections(IndexSet(integer: sectionIndex), with: .none)
        
            view.registerTextField.text = ""
        }
    }
}

// MARK: - SelectSectionButtonDelegate extension
extension TodoListViewController : SelectSectionButtonDelegate {
    func selectSectionButtonTapped(forView view: TodoTableViewHeaderView) {
        if let sectionName = view.sectionNameLabel.text {
            registerView.addTodoButton.setTitle(sectionName, for: .normal)
        }
    }
}


