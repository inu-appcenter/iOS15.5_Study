//
//  SectionHeaderReusableView.swift
//  ToDoListApp
//
//  Created by 이대현 on 2023/11/15.
//

import UIKit
import SnapKit

class TaskHeaderView: UITableViewHeaderFooterView {
    static let identifier: String = "TaskHeaderView"
    private lazy var headerTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 34)
        label.frame = label.bounds
        return label
    }()
    
    func setTitle(_ title: String) {
        headerTitleLabel.text = title
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addSubview(headerTitleLabel)
        headerTitleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(30)
            make.right.top.bottom.equalToSuperview()
        }
        headerTitleLabel.text = "헤더"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
