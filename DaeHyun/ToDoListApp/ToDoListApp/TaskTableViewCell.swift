//
//  TaskTableViewCell.swift
//  ToDoListApp
//
//  Created by 이대현 on 2023/11/09.
//

import SnapKit
import UIKit

final class TaskTableViewCell: UITableViewCell {
    private lazy var checkButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .systemBackground
        config.baseForegroundColor = .red
        config.image = UIImage(systemName: "checkmark.circle.fill")
        
        let button = UIButton(configuration: config)
        return button
    }()
    
    private lazy var taskLabel: UILabel = {
        let label = UILabel()
        label.text = "Walking"
        return label
    }()
    
    private lazy var deleteButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .systemBackground
        config.baseForegroundColor = .gray
        config.image = UIImage(systemName: "xmark.circle.fill")
        
        let button = UIButton(configuration: config)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        self.addSubview(checkButton)
        checkButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.width.equalTo(checkButton.snp.height)
        }
        
        self.addSubview(deleteButton)
        deleteButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.width.equalTo(deleteButton.snp.height)
        }
        
        self.addSubview(taskLabel)
        taskLabel.snp.makeConstraints { make in
            make.top.equalTo(checkButton.snp.top)
            make.left.equalTo(checkButton.snp.right).offset(20)
            make.bottom.equalTo(checkButton.snp.bottom)
            make.right.equalTo(deleteButton.snp.left).offset(-20)
        }
        
    }
}

extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}
