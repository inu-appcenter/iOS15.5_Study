//
//  ManageSectionViewController.swift
//  todoAPP
//
//  Created by Bowon Han on 11/10/23.
//

import UIKit
import SnapKit

class ManageSectionViewController : UIViewController {
    private let saveData = SaveData.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setLayout()
        configureTableView()
    }
    
    private lazy var sectionTableView : UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    private func configureTableView() {
        sectionTableView.delegate = self
        sectionTableView.dataSource = self
        
        sectionTableView.register(SectionTableViewCell.self, forCellReuseIdentifier: SectionTableViewCell.identifier)
    }
        
    private func setLayout() {
        view.addSubview(sectionTableView)
        
        sectionTableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.bottom.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(5)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-5)
        }
    }
}

// MARK: - UITableView extension
extension ManageSectionViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionData = saveData.dataSource[indexPath.row]
        print(sectionData.sectionName)

        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: SectionTableViewCell.identifier,
            for: indexPath
        ) as? SectionTableViewCell else {
            fatalError("Failed to dequeue a cell.")
        }
        cell.selectionStyle = .none
        cell.sectionNameLabel.text = sectionData.sectionName

        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return saveData.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            saveData.dataSource.remove(at: indexPath.row)
            
            saveData.saveAllData()

            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

}
