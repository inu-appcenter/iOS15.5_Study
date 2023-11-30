//
//  TaskTableViewCell.swift
//  ToDoListApp
//
//  Created by 이대현 on 2023/11/09.
//

import SnapKit
import UIKit

protocol TaskTableViewCellDelegate: AnyObject {
    func removeTask(forCell cell: TaskTableViewCell)
    func setIsComplete(forCell cell: TaskTableViewCell, _ isComplete: Bool)
}

final class TaskTableViewCell: UITableViewCell {
    weak var delegate: TaskTableViewCellDelegate?
    
    private var isTaskComplete: Bool = false {
        didSet {
            delegate?.setIsComplete(forCell: self, isTaskComplete)
            if isTaskComplete {
                checkButton.configuration?.image = UIImage(systemName: "checkmark.circle.fill")
                taskLabel.textColor = .lightGray
                taskLabel.strikethrough(from: taskLabel.text, at: taskLabel.text)
                deleteButton.configuration?.image = UIImage(systemName: "xmark.circle.fill")
            } else {
                checkButton.configuration?.image = UIImage(systemName: "circle")
                taskLabel.textColor = .black
                taskLabel.unsetStrikethrough(from: taskLabel.text, at: taskLabel.text)
                deleteButton.configuration?.image = nil
            }
            
        }
    }
    
    private lazy var checkButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .systemBackground
        config.baseForegroundColor = .red
        config.image = UIImage(systemName: "circle")
        let button = UIButton(configuration: config)
        button.addAction(UIAction { [weak self] _ in
            if let isTaskComplete = self?.isTaskComplete {
                self?.isTaskComplete = !isTaskComplete
            }
        }, for: .touchUpInside)
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
        button.addAction(UIAction { [weak self] _ in
            if let self = self {
                self.delegate?.removeTask(forCell: self)
            }
        }, for: .touchUpInside)
        return button
    }()
    
    func setupUI(task: Task) {
        self.taskLabel.text = task.name
        self.isTaskComplete = task.isCompleted
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        contentView.addSubview(checkButton)
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
