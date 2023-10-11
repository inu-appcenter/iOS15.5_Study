//
//  ViewController.swift
//  MemberListApp
//
//  Created by 이대현 on 2023/10/11.
//

import SnapKit
import UIKit

final class MemberListViewController: UIViewController {
    private lazy var memberListTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MemberTableViewCell.self, forCellReuseIdentifier: MemberTableViewCell.cellId)
        return tableView
    }()
    
    private lazy var rightBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addButtonTouched(_:))
        )
        return button
    }()
    
    @objc func addButtonTouched (_ sender: Any) {
        let detailVC = MemberDetailViewController(mode: .create, data: nil)
        self.navigationController?.pushViewController(detailVC, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        memberListTableView.reloadData()
        super.viewWillAppear(animated)
    }
    
    private func layout() {
        self.navigationItem.title = "회원 목록"
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        self.view.addSubview(memberListTableView)
        memberListTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension MemberListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MemberManager.shared.members.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MemberTableViewCell.cellId) as? MemberTableViewCell
        else {
            return UITableViewCell()
        }
        cell.setupUI(data: MemberManager.shared.members[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = MemberDetailViewController(mode: .update, data: MemberManager.shared.members[indexPath.row])
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
