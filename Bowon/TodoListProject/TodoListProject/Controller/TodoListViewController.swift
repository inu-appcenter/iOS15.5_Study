//
//  TodoListViewController.swift
//  TodoListProject
//
//  Created by Bowon Han on 11/19/23.
//

import UIKit
import SnapKit

class TodoListViewController: UIViewController {
    private let saveData = SaveData.shared
    
    var registerViewBottomConstraint : NSLayoutConstraint?
    let scrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setLayout()
        configureTableView()
        keyboardLayout()
        SaveData.shared.loadAllData()
        configureScrollViewInset()
        configureRegisterViewButtonTitle()
    
        self.view.gestureRecognizers?.removeAll()
    }
    
// MARK: - keyboard
    override func viewWillAppear(_ animated: Bool) {
        self.addKeyboardNotifications()
    }
        
    override func viewWillDisappear(_ animated: Bool) {
        self.removeKeyboardNotifications()
        saveData.saveAllData()
    }
    
    func keyboardLayout() {
        let safeArea = self.view.safeAreaLayoutGuide
            
        self.registerViewBottomConstraint = NSLayoutConstraint(item: self.registerView, attribute: .bottom, relatedBy: .equal, toItem: safeArea, attribute: .bottom, multiplier: 1.0, constant: 0)
        self.registerViewBottomConstraint?.isActive = true
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
            self.registerViewBottomConstraint?.constant = -1 * keyboardHeight
            
            self.view.layoutIfNeeded()
        }
    }

    @objc func keyboardWillHide(_ noti: NSNotification) {
        if let keyboardFrame: NSValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            self.registerViewBottomConstraint?.constant = keyboardHeight
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
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
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
    
    private func configureRegisterViewButtonTitle() {
        if let firstSection = saveData.dataSource.first {
            let firstSectionName = firstSection.sectionName
            registerView.addTodoButton.setTitle(firstSectionName, for: .normal)
        }
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
        cell.prepareLabel(
            todoListLabel:todayModel.todoNameLabel
        )
        
        cell.delegate = self
        cell.selectionStyle = .none
        
        let successOrNot = todayModel.success
        print(successOrNot)
        
        if successOrNot {
            cell.complete()
        }
        else {
            cell.unComplete()
        }

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
        let sectionData = saveData.dataSource[indexPath.section]
        
        let todoListDetail = sectionData.list[indexPath.row]

        let detailVC = DetailViewController()
        detailVC.detailViewListName.text = todoListDetail.todoNameLabel
        detailVC.sectionNumber = indexPath.section
        detailVC.indexNumber = indexPath.row
        
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            var section = saveData.dataSource[indexPath.section]
            
            section.list.remove(at: indexPath.row)
            
            saveData.dataSource[indexPath.section] = section

            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionData = saveData.dataSource[section]
        
        let todoTableViewHeaderView = SectionHeaderView()

        todoTableViewHeaderView.delegate = self
        todoTableViewHeaderView.sectionNameLabel.text = sectionData.sectionName
        
        return todoTableViewHeaderView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let todoTableViewHeaderView = SectionHeaderView()
        
        let intrinsicHeight = todoTableViewHeaderView.intrinsicContentSize.height
        
        return intrinsicHeight
    }
}

// MARK: - ButtonTappedDelegate extension
extension TodoListViewController : ButtonTappedDelegate {
    func tapFinishButton(forCell cell: TodoTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell)
        else { return }
        
        let sectionIndex = indexPath.section
        let itemIndex = indexPath.row
        
        let successValue = saveData.dataSource[sectionIndex].list[itemIndex].success
        
        if !successValue {
            cell.complete()
            saveData.dataSource[sectionIndex].list[itemIndex].success = true
        }
        
        else {
            cell.unComplete()
            saveData.dataSource[sectionIndex].list[itemIndex].success = false
        }
    }
    
    func tapDeleteButton(forCell cell: TodoTableViewCell) {
        if let indexPath = tableView.indexPath(for: cell),
           indexPath.section < saveData.dataSource.count {
            var section = saveData.dataSource[indexPath.section]
            
            if indexPath.row < section.list.count {
                section.list.remove(at: indexPath.row)

                saveData.dataSource[indexPath.section] = section
                
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
            let newTodo = TodoListModel(success: false, todoNameLabel: text,startDate: nil, endDate: nil)
       
            if saveData.dataSource.isEmpty {
                let newSection = Model(list: [newTodo], sectionName: "Today")
                saveData.dataSource.append(newSection)
            }
            else {
                if let sectionName = view.addTodoButton.title(for: .normal) {
                    if let sectionIndex = saveData.dataSource.firstIndex(where: { $0.sectionName == sectionName }) {
                        saveData.dataSource[sectionIndex].list.append(newTodo)
                        
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
            let newSection = Model(list: [], sectionName: text)
            saveData.dataSource.append(newSection)
            
            let sectionIndex = saveData.dataSource.count - 1
            tableView.insertSections(IndexSet(integer: sectionIndex), with: .none)
        
            view.registerTextField.text = ""
        }
    }
}

// MARK: - SelectSectionButtonDelegate extension
extension TodoListViewController : SelectSectionButtonDelegate {
    func selectSectionButtonTapped(forView view: SectionHeaderView) {
        if let sectionName = view.sectionNameLabel.text {
            registerView.addTodoButton.setTitle(sectionName, for: .normal)
        }
    }
}


