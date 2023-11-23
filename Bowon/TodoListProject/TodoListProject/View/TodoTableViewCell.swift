//
//  TodoTableViewCell.swift
//  TodoListProject
//
//  Created by Bowon Han on 11/19/23.
//

import UIKit
import SnapKit

protocol ButtonTappedDelegate : AnyObject {
    func tapFinishButton(forCell cell: TodoTableViewCell)
    func tapDeleteButton(forCell cell: TodoTableViewCell)
}

final class TodoTableViewCell : UITableViewCell {
    weak var delegate : ButtonTappedDelegate?
        
    lazy var deleteButton : UIButton = {
        let button = UIButton()
        button.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        button.tintColor = .lightGray
        button.addTarget(self, action: #selector(tabDeleteButton), for: .touchUpInside)
        
        return button
    }()
    
    lazy var checkButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "circle"), for: .normal)
        button.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        button.tintColor = .darkGreen
        button.addTarget(self, action: #selector(tabFinishButton), for: .touchUpInside)
        
        return button
    }()
        
    var todoListLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        return label
    }()
    
    private lazy var stackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 15
        stackView.distribution = .fill
        stackView.alignment = .center
    
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
        stackViewLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    func complete() {
        checkButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
                
        todoListLabel.textColor = .lightGray
        todoListLabel.strikethroughAndChangeLineColor(from: todoListLabel.text, at: todoListLabel.text)
                
        deleteButton.setImage(UIImage(systemName: "multiply.circle.fill"), for: .normal)
        print("complete")
    }
    
    func unComplete() {
        checkButton.setImage(UIImage(systemName: "circle"), for: .normal)
            
        todoListLabel.textColor = .black
        todoListLabel.unsetStrikethrough(from: todoListLabel.text, at: todoListLabel.text)
            
        deleteButton.setImage(nil, for: .normal)
        print("unComplete")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.prepareLabel(todoListLabel: nil)
    }

    func prepareLabel(todoListLabel: String?) {
        self.todoListLabel.text = todoListLabel
    }
    
    @objc func tabFinishButton(_:UIButton){
        delegate?.tapFinishButton(forCell: self)
    }
    
    @objc func tabDeleteButton(_:UIButton){
        delegate?.tapDeleteButton(forCell: self)
    }
    
// MARK: - layout
    private func stackViewLayout(){
        [checkButton,todoListLabel,deleteButton].forEach{
            stackView.addArrangedSubview($0)
        }
    }
    
    private func setLayout(){
        checkButton.snp.makeConstraints {
            $0.width.greaterThanOrEqualTo(30)
        }
        
        deleteButton.snp.makeConstraints {
            $0.width.greaterThanOrEqualTo(30)
        }
        
        contentView.addSubview(stackView)
                
        stackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(5)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-30)
            $0.bottom.equalToSuperview().offset(-5)
            $0.height.equalTo(40)
        }
    }
}

