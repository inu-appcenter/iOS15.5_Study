//
//  SettingViewController.swift
//  TodoAPP_project
//
//  Created by Bowon Han on 11/26/23.
//

import UIKit
import SnapKit

class SettingViewController: UIViewController {
    var setting : [String] = ["Support","About","Version"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray5
        setLayout()
        configure()
    }
    
    private lazy var settingTableView : UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .insetGrouped)
        tableView.backgroundColor = .systemGray5
        
        return tableView
    }()
    
    private func setLayout() {
        view.addSubview(settingTableView)
        
        settingTableView.snp.makeConstraints {
            $0.top.trailing.leading.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configure() {
        settingTableView.delegate = self
        settingTableView.dataSource = self
        settingTableView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
    }
}

// MARK: - extension
extension SettingViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = settingTableView.dequeueReusableCell(
            withIdentifier: SettingTableViewCell.identifier,
            for: indexPath
        ) as? SettingTableViewCell else {
            return UITableViewCell()
        }
        
        cell.settingTitleLabel.text = setting[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "TODO APP"
    }
}
